#!/usr/bin/env python
"""Measure vertical overflow per slide in rendered Reveal.js decks.

Policy (slides/ucla-theme.css decks, 1280x720 canvas): no slide may scroll
vertically. This tool measures every slide's scrollHeight vs clientHeight in
headless Chrome and flags slides that overflow.

Measurement guarantees (each was a real debugging lesson):
  - section { display:block } lays out every slide (including ones nested
    inside `# Part` sections) without navigating the deck;
  - .fragment { visibility:visible } includes content hidden behind
    `. . .` build steps — NEVER measure at fragment 0 only;
  - waits for MathJax to typeset every display span and for all images
    (including Quarto's data-src lazy images) to finish loading — an
    unloaded image reports height 0 and corrupts the measurement;
  - polls scrollHeight across repeated passes until stable (MathJax layout
    settles asynchronously);
  - scrollHeight/clientHeight ignore Reveal's CSS transform scale, so
    results are resolution-independent.

A slide overflows iff scrollHeight > clientHeight AND its computed
overflow-y is auto/scroll. `# Part N` divider slides are overflow:visible
and shrink-wrapped — they never scroll and are never flagged.

Usage:
    python check_overflow.py slides/foo.html slides/bar.html
    python check_overflow.py --all                 # every slides/*.html
    python check_overflow.py --all --dump out.json # raw measurements
    python check_overflow.py --qmd slides/foo.qmd  # resolve .qmd -> .html

Exits 1 if any slide overflows (unless --warn-only).
Requires headless Chrome/Chromium (auto-detected, or set CHROME_BIN).
The `what-are-networks` deck (embed-resources) is skipped automatically:
it is unmeasurable by this tool.
"""
import argparse
import glob
import http.server
import json
import os
import shutil
import subprocess
import sys
import tempfile
import threading
import time
import urllib.parse

WINDOW_W, WINDOW_H = 1280, 720
UNMEASURABLE = {"what-are-networks"}  # embed-resources: empty DOM dump

MEASURE_SCRIPT = r"""
<style>
  section { display: block !important; }
  .fragment { visibility: visible !important; }
</style>
<script>
(function(){
  document.querySelectorAll('img[data-src]').forEach(function(img){
    img.setAttribute('src', img.getAttribute('data-src'));
  });
  function measure(){
    try {
      var out = [];
      document.querySelectorAll('.reveal .slides > section').forEach(function(top){
        var slides = top.tagName === 'SECTION' && top.querySelector(':scope > section')
          ? top.querySelectorAll(':scope > section') : [top];
        slides.forEach(function(sec){ out.push(slideInfo(sec)); });
      });
      fetch('http://127.0.0.1:__PORT__/done', {method: 'POST', body: JSON.stringify(out)});
    } catch (e) {
      location.href = 'http://127.0.0.1:__PORT__/?ERR|' +
        encodeURIComponent(String(e && (e.stack || e.message) || e));
    }
  }
  function slideInfo(sec){
    var h = sec.querySelector('h1,h2,h3');
    return {
      id: sec.id || '(no-id)',
      title: h ? h.textContent.trim().slice(0, 80) : '',
      sh: sec.scrollHeight, ch: sec.clientHeight,
      oy: getComputedStyle(sec).overflowY,
      frag: sec.querySelectorAll('.fragment').length
    };
  }
  function settleCheck(){
    var untyped = Array.prototype.filter.call(
      document.querySelectorAll('span.math.display'),
      function(s){ return !s.querySelector('.MathJax_Display'); }).length;
    var pending = Array.prototype.filter.call(
      document.querySelectorAll('img'),
      function(i){ return !i.complete; }).length;
    return untyped === 0 && pending === 0 &&
           !!(window.Reveal && Reveal.isReady && Reveal.isReady());
  }
  var stable = 0, tries = 0, last = '';
  function poll(){
    if (settleCheck()) {
      var sig = Array.prototype.map.call(
        document.querySelectorAll('.reveal .slides section'),
        function(s){ return s.scrollHeight; }).join(',');
      stable = (sig === last) ? stable + 1 : 0;
      last = sig;
    } else { stable = 0; }
    tries++;
    // Escape threshold must stay WELL below the virtual-time budget:
    // 900 timers * 150ms = 135k virtual ms exhausts the 300k budget when
    // combined with other page timers, and Chrome exits before measure().
    // stable>=4 fires almost immediately (layout settles at once).
    if ((stable >= 4 && tries > 20) || tries > 200) { measure(); return; }
    setTimeout(poll, 150);
  }
  setTimeout(poll, 800);
})();
</script>
"""


def find_chrome():
    # Prefer chrome-headless-shell: a dedicated binary that can NEVER hand
    # off to the user's running browser. Plain chrome.exe intermittently
    # does exactly that on Windows when launched from an elevated shell
    # ("Opening in existing browser session", exits in ~0.1s, page never
    # loads) — silent measurement failures.
    shell = os.path.join(
        os.path.expanduser("~"), ".posit-assistant", "tools",
        "chrome-headless-shell", "chrome-headless-shell-win64",
        "chrome-headless-shell.exe")
    if os.path.exists(shell):
        return shell
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
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    ]
    for c in candidates:
        if os.path.exists(c):
            return c
    for name in ("google-chrome", "google-chrome-stable", "chromium"):
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

    def do_POST(self):
        # POST transport: immune to the request-line length limit that
        # breaks GET query strings for large per-slide payloads.
        length = int(self.headers.get("Content-Length", 0))
        self.server.payload = self.rfile.read(length).decode("utf-8")
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(b"ok")

    def log_message(self, *args):
        pass


def collect(html_path, chrome_bin, attempts=4):
    """Run the deck in headless Chrome, return the per-slide measurement list.

    Launches are FLAKY in some environments (observed on Windows: when the
    shell is elevated, Chrome de-elevation relaunch sometimes silently exits
    without loading the page, roughly every other run). Each attempt gets a
    fresh isolated profile; the first successful payload wins.
    """
    for attempt in range(attempts):
        result = _collect_once(html_path, chrome_bin)
        if result is not None:
            return result
        time.sleep(1.0 + attempt)
    return None


def _collect_once(html_path, chrome_bin):
    server = http.server.HTTPServer(("127.0.0.1", 0), Receiver)
    server.payload = None
    port = server.server_address[1]
    threading.Thread(target=server.serve_forever, daemon=True).start()

    with open(html_path, encoding="utf-8") as f:
        content = f.read()
    # The instrumented copy must live next to the original so relative
    # resources (<deck>_files/...) still resolve.
    base = os.path.basename(html_path)
    tmp_name = os.path.join(
        os.path.dirname(os.path.abspath(html_path)),
        f".{base}.overflow-{os.getpid()}.html")
    with open(tmp_name, "w", encoding="utf-8") as f:
        f.write(content.replace(
            "</body>", MEASURE_SCRIPT.replace("__PORT__", str(port)) + "</body>"))
    import pathlib
    url = pathlib.Path(tmp_name).as_uri()

    shot = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
    shot.close()
    profile = tempfile.mkdtemp(prefix="overflow-profile-")
    try:
        # Isolated profile per run: a leftover zombie Chrome holding the
        # default profile lock silently breaks every subsequent launch.
        cmd = [chrome_bin, "--headless=new", "--disable-gpu", "--no-sandbox",
               "--force-device-scale-factor=1",
               "--user-data-dir=" + profile,
               "--window-size=%d,%d" % (WINDOW_W, WINDOW_H),
               "--virtual-time-budget=300000",
               "--screenshot=" + shot.name, url]
        try:
            subprocess.run(cmd, capture_output=True, timeout=300)
        except subprocess.TimeoutExpired:
            pass
        deadline = time.time() + 30
        while server.payload is None and time.time() < deadline:
            time.sleep(0.25)
    finally:
        server.shutdown()
        os.unlink(tmp_name)
        shutil.rmtree(profile, ignore_errors=True)
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


def resolve_deck(path):
    """Accept .qmd or .html; return the rendered .html path or None."""
    if path.endswith(".qmd"):
        html = path[:-4] + ".html"
        if not os.path.exists(html):
            print(f"  [SKIP] no rendered HTML for {path} "
                  f"(render it with: quarto render {path})", flush=True)
            return None
        return html
    return path if os.path.exists(path) else None


def check_deck(html, chrome_bin):
    name = os.path.basename(html)
    stem = os.path.splitext(name)[0]
    if stem in UNMEASURABLE:
        print(f"{name}: SKIP (embed-resources deck, unmeasurable)", flush=True)
        return None
    data = collect(html, chrome_bin)
    if data is None:
        print(f"{name}: NO MEASUREMENTS (Chrome produced no payload)", flush=True)
        return None
    bad = [s for s in data
           if s["sh"] > s["ch"] and s["oy"] in ("auto", "scroll")]
    print(f"{name}: {len(data)} slides, {len(bad)} overflowing", flush=True)
    for s in sorted(bad, key=lambda s: s["sh"] - s["ch"], reverse=True):
        print(f"    sh={s['sh']} ch={s['ch']} (+{s['sh'] - s['ch']}) "
              f"frag={s['frag']} #{s['id']} — {s['title']}", flush=True)
    return {"deck": name, "slides": data, "overflow": bad}


def main():
    # Windows consoles default to a legacy codepage; slide titles contain
    # typographic characters (’ ∘ …) that crash print() without this.
    if sys.stdout.encoding and sys.stdout.encoding.lower() not in ("utf-8", "utf8"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("decks", nargs="*", help=".html or .qmd slide files")
    ap.add_argument("--all", action="store_true", help="audit every slides/*.html")
    ap.add_argument("--dump", metavar="PATH", help="write raw measurements as JSON")
    ap.add_argument("--warn-only", action="store_true", help="always exit 0")
    args = ap.parse_args()

    files = args.decks
    if args.all or not files:
        files = sorted(glob.glob(os.path.join("slides", "*.html")))
    resolved = [h for h in (resolve_deck(f) for f in files) if h]

    chrome = find_chrome()
    if chrome is None:
        print("[ERROR] No headless-capable Chrome/Chromium found. "
              "Set CHROME_BIN or install Chrome.", flush=True)
        return 1

    results, failed = [], []
    for h in resolved:
        try:
            r = check_deck(h, chrome)
        except Exception as e:  # noqa: BLE001 - report and keep going
            print(f"{os.path.basename(h)}: ERROR {e}", flush=True)
            failed.append(h)
            continue
        if r is None:
            failed.append(h)
        else:
            results.append(r)

    if args.dump:
        with open(args.dump, "w", encoding="utf-8") as fh:
            json.dump(results, fh)

    n_overflow = sum(len(r["overflow"]) for r in results)
    print(f"\nTOTAL overflowing slides: {n_overflow} "
          f"across {len(results)} decks "
          f"({len(failed)} deck(s) skipped/failed)", flush=True)
    if failed:
        print("Not measured: " + ", ".join(os.path.basename(f) for f in failed))
    if n_overflow and not args.warn_only:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
