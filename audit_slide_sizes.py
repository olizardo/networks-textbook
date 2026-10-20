#!/usr/bin/env python
"""Audit rendered Reveal.js slide decks for minimum size floors.

Measures the actual on-canvas rendered size of display math (matrices) and
figures by loading each deck in headless Chrome, waiting for MathJax to
typeset, and reading element bounding boxes. Flags:

  - display math rendered below the font-size floor (default 34px on the
    deck canvas; matches --r-main-font-size in slides/ucla-theme.css)
  - display math wider than the usable slide width (overflows the margin)
  - display math that never typeset (students would see raw LaTeX)
  - figures displayed below the minimum raster scale (plot text shrinks
    proportionally when a figure is downscaled)

Usage:
    python audit_slide_sizes.py slides/matrix-operations.qmd slides/matrix-advanced.qmd
    python audit_slide_sizes.py --warn-only          # report, never fail
    python audit_slide_sizes.py --no-render           # audit existing .html only

Exits 1 if any violation is found (unless --warn-only).
Requires headless Chrome/Chromium (auto-detected, or set CHROME_BIN).
"""
import argparse
import glob
import http.server
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import time
import urllib.parse

# ---------------------------------------------------------------------------
# Floors (canvas pixels; decks are 1280x720 with 0.1 margins -> 1024 usable)
# ---------------------------------------------------------------------------
MATH_FLOOR_PX = 34.0        # display math must render at >= the deck base font
DENSE_MATH_FLOOR_PX = 20.8  # inside .math-dense wrappers: 72% of prose (28.9px)
USABLE_WIDTH_PX = 1024       # 1280 * (1 - 2 * 0.1)
MIN_IMG_SCALE = 0.75         # displayed size must be >= 75% of intended size
MIN_INTENDED_IN = 3.3        # figures must be authored >= 3.3in wide
WINDOW_W, WINDOW_H = 1280, 720

MEASURE_SCRIPT = r"""
<style>
  section { display: block !important; visibility: visible !important; }
</style>
<script>
(function(){
  document.querySelectorAll('img[data-src]').forEach(function(img){
    img.setAttribute('src', img.getAttribute('data-src'));
  });
  function measure(){
    var out = [];
    // Normalize for Reveal.js's global slide scale: getBoundingClientRect
    // includes the CSS transform, so divide it out to get true canvas px.
    var rs = (window.Reveal && Reveal.getScale) ? Reveal.getScale() : 1;
    document.querySelectorAll('section[id]').forEach(function(sec){
      sec.querySelectorAll('.MathJax_Display').forEach(function(el){
        // MathJax_Display is a full-width block div; the typeset math is
        // the span inside it. Measure that, falling back to the div.
        var target = el.firstElementChild || el;
        var r = target.getBoundingClientRect();
        out.push({slide: sec.id, kind: 'math', w: Math.round(r.width / rs),
                  h: Math.round(r.height / rs), fs: getComputedStyle(el).fontSize,
                  dense: !!(el.closest && el.closest('.math-dense')),
                  dbg: (el.firstElementChild ? el.firstElementChild.className + '/' + el.firstElementChild.tagName : 'NONE')});
      });
      sec.querySelectorAll('span.math.display').forEach(function(span){
        if (!span.querySelector('.MathJax_Display')) {
          var s = span.querySelector('script');
          out.push({slide: sec.id, kind: 'untyped',
                    tex: s ? s.textContent.slice(0, 80) : ''});
        }
      });
      sec.querySelectorAll('img').forEach(function(img){
        var r = img.getBoundingClientRect();
        if (r.width > 0) out.push({slide: sec.id, kind: 'img',
          w: Math.round(r.width / rs), h: Math.round(r.height / rs),
          natw: img.naturalWidth, nath: img.naturalHeight,
          intended: img.getAttribute('width') || '',
          src: img.getAttribute('src') || img.getAttribute('data-src') || ''});
      });
    });
    location.href = 'http://127.0.0.1:__PORT__/?' + encodeURIComponent(JSON.stringify(out));
  }
  function untypedCount(){
    return Array.prototype.filter.call(
      document.querySelectorAll('span.math.display'),
      function(s){ return !s.querySelector('.MathJax_Display'); }).length;
  }
  function imgsPending(){
    return Array.prototype.filter.call(
      document.querySelectorAll('img'),
      function(i){ return !i.complete; }).length;
  }
  var stable = 0, tries = 0;
  function poll(){
    var ready = untypedCount() === 0 && imgsPending() === 0;
    stable = ready ? stable + 1 : 0;
    tries++;
    if ((stable >= 5 || tries > 900) && tries > 20) { measure(); return; }
    setTimeout(poll, 100);
  }
  setTimeout(poll, 500);
})();
</script>
"""


def find_chrome():
    env = os.environ.get("CHROME_BIN") or os.environ.get("CHROME_PATH")
    if env and os.path.exists(env):
        return env
    candidates = [
        r"C:\Program Files\Google\Chrome\Application\chrome.exe",
        r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
        r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
        "/usr/bin/google-chrome",
        "/usr/bin/google-chrome-stable",
        "/usr/bin/chromium",
        "/usr/bin/chromium-browser",
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    ]
    for c in candidates:
        if os.path.exists(c):
            return c
    for name in ("google-chrome", "google-chrome-stable", "chromium",
                 "chromium-browser"):
        path = shutil.which(name)
        if path:
            return path
    return None


class Receiver(http.server.BaseHTTPRequestHandler):
    """One-shot server that captures the browser's measurement payload."""

    def do_GET(self):
        if self.path.startswith("/?"):
            self.server.payload = urllib.parse.unquote(self.path[2:])
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(b"ok")

    def log_message(self, *args):
        pass


def collect_measurements(html_path, chrome_bin):
    """Run the deck in headless Chrome and return the measurement list."""
    server = http.server.HTTPServer(("127.0.0.1", 0), Receiver)
    server.payload = None
    port = server.server_address[1]
    threading.Thread(target=server.serve_forever, daemon=True).start()

    with open(html_path, encoding="utf-8") as f:
        content = f.read()
    # The instrumented copy must live next to the original so that the
    # deck's relative resources (e.g. <deck>_files/...) still resolve.
    base = os.path.basename(html_path)
    tmp_name = os.path.join(
        os.path.dirname(os.path.abspath(html_path)),
        f".{base}.audit-{os.getpid()}.html",
    )
    with open(tmp_name, "w", encoding="utf-8") as f:
        f.write(content.replace(
            "</body>", MEASURE_SCRIPT.replace("__PORT__", str(port)) + "</body>"))
    import pathlib
    url = pathlib.Path(tmp_name).as_uri()

    shot = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
    shot.close()
    try:
        cmd = [chrome_bin, "--headless=new", "--disable-gpu", "--no-sandbox",
               "--force-device-scale-factor=1",
               "--window-size=%d,%d" % (WINDOW_W, WINDOW_H),
               "--virtual-time-budget=90000",
               "--screenshot=" + shot.name, url]
        try:
            subprocess.run(cmd, capture_output=True, timeout=120)
        except subprocess.TimeoutExpired:
            pass
        deadline = time.time() + 30
        while server.payload is None and time.time() < deadline:
            time.sleep(0.25)
    finally:
        server.shutdown()
        os.unlink(tmp_name)
        try:
            os.unlink(shot.name)
        except OSError:
            pass

    if server.payload is None:
        return None
    try:
        return json.loads(server.payload)
    except json.JSONDecodeError:
        return None


def ensure_rendered(qmd, force):
    """Return path to rendered HTML, rendering via quarto if needed."""
    html = qmd[:-4] + ".html"
    if not force and os.path.exists(html):
        css_files = glob.glob(os.path.join(os.path.dirname(qmd) or ".", "*.css"))
        qmd_mtime = os.path.getmtime(qmd)
        stale = any(os.path.getmtime(c) > os.path.getmtime(html) for c in css_files)
        if not stale and os.path.getmtime(html) >= qmd_mtime:
            return html
    print(f"  rendering {qmd} ...")
    result = subprocess.run(["quarto", "render", qmd],
                            capture_output=True, text=True)
    if result.returncode != 0:
        print(f"  [ERROR] quarto render failed for {qmd}:\n{result.stdout}\n{result.stderr}")
        return None
    return html if os.path.exists(html) else None


def audit_deck(qmd, chrome_bin, force_render, no_render):
    print(f"Auditing {qmd}")
    tag = os.path.basename(qmd)
    html = qmd[:-4] + ".html"
    if no_render:
        if not os.path.exists(html):
            print(f"  [SKIP] no rendered HTML for {qmd} (--no-render)")
            return []
    else:
        html = ensure_rendered(qmd, force_render)
    if html is None or not os.path.exists(html):
        return [("deck", tag, "could not render deck")]
    data = collect_measurements(html, chrome_bin)
    if data is None:
        return [("deck", tag, "no measurements received from headless Chrome")]

    violations = []
    n_math = n_img = n_untyped = 0
    for d in data:
        kind = d.get("kind")
        slide = d.get("slide", "?")
        if kind == "math":
            n_math += 1
            fs = float(re.sub(r"[^0-9.]", "", d.get("fs", "0")) or 0)
            floor = DENSE_MATH_FLOOR_PX if d.get("dense") else MATH_FLOOR_PX
            if d["w"] == 0 or d["h"] == 0:
                violations.append((slide, "math",
                    f"display math block has zero size (not typeset?)"))
                continue
            if fs and fs < floor:
                violations.append((slide, "math",
                    f"display math at {fs:g}px is below the {floor:g}px floor"))
            if d["w"] > USABLE_WIDTH_PX:
                violations.append((slide, "math",
                    f"display math {d['w']}px wide exceeds usable width "
                    f"{USABLE_WIDTH_PX}px — split or restructure the equation"))
        elif kind == "untyped":
            n_untyped += 1
            violations.append((slide, "math",
                f"display math never typeset (raw LaTeX visible): {d.get('tex', '')[:60]}"))
        elif kind == "img":
            n_img += 1
            # knitr emits width= attributes in CSS px (the intended display
            # size); the raster is 2x (retina). Scale against the intended
            # size, not the raw raster.
            intended = float(d.get("intended") or 0) or d.get("natw") or 0
            if intended:
                scale = d["w"] / intended
                if scale < MIN_IMG_SCALE:
                    violations.append((slide, "img",
                        f"figure displayed at {scale:.0%} of its intended "
                        f"{intended:.0f}px (<{MIN_IMG_SCALE:.0%}; plot text "
                        f"shrinks with it)"))
                if intended < MIN_INTENDED_IN * 96 - 1:
                    violations.append((slide, "img",
                        f"figure authored at {intended / 96:.1f}in wide "
                        f"(<{MIN_INTENDED_IN}in minimum)"))
    print(f"  {n_math} math blocks, {n_img} figures, {n_untyped} untyped, "
          f"{len(violations)} violations")
    # tag each violation with the deck so the combined report is unambiguous
    return [(tag, kind, f"{slide}: {msg}") for (slide, kind, msg) in violations]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("decks", nargs="*", help="slide .qmd files (default: slides/*.qmd)")
    parser.add_argument("--warn-only", action="store_true",
                        help="report violations but always exit 0")
    parser.add_argument("--no-render", action="store_true",
                        help="audit existing .html only; skip missing decks")
    parser.add_argument("--always-render", action="store_true",
                        help="re-render decks even if HTML looks fresh")
    parser.add_argument("--dump", metavar="PATH",
                        help="write raw measurements (all elements) as JSON")
    args = parser.parse_args()

    decks = args.decks or sorted(glob.glob(os.path.join("slides", "*.qmd")))
    if not decks:
        print("No slide decks found.")
        return 0
    chrome = find_chrome()
    if chrome is None:
        print("[ERROR] No headless-capable Chrome/Chromium found. "
              "Set CHROME_BIN or install Chrome.")
        return 1
    print(f"Using browser: {chrome}")

    all_violations = []
    raw = []
    for qmd in decks:
        viol = audit_deck(qmd, chrome, args.always_render, args.no_render)
        all_violations.extend(viol)
        if args.dump:
            html = qmd[:-4] + ".html"
            if os.path.exists(html):
                data = collect_measurements(html, chrome)
                if data:
                    raw.append({"deck": os.path.basename(qmd), "data": data})
    if args.dump:
        with open(args.dump, "w", encoding="utf-8") as f:
            json.dump(raw, f)

    if all_violations:
        print(f"\n{len(all_violations)} size-floor violation(s):")
        for slide, kind, msg in all_violations:
            print(f"  [{kind:4s}] {slide}: {msg}")
    else:
        print("\nAll decks meet the size floors.")

    if all_violations and not args.warn_only:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
