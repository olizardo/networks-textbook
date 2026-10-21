#!/usr/bin/env python
"""Print settled per-element geometry for one or more slides in a deck.

The diagnostic companion to check_overflow.py: when a slide overflows
(scrollHeight > clientHeight), this tool shows exactly WHICH element pushes
it over — elements sorted by their bottom edge, with the slide's bottom
marked, so the culprit (usually the tallest column, a table, or a display
math block) is immediately visible.

Uses the same Chrome-injection guarantees as check_overflow.py: every slide
laid out (section display:block), every fragment visible, MathJax typeset,
all images loaded, scrollHeight stable. Element geometry is normalized by
Reveal.getScale() so numbers are true canvas px.

Usage:
    python dump_slide.py slides/foo.html <slide-id-or-prefix> [...]
    python dump_slide.py slides/foo.html --overflow   # dump flagged slides
    python dump_slide.py slides/foo.html --all        # dump every slide
"""
import argparse
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
  window.__SLIDES__ = null;
  function measure(){
    var rs = (window.Reveal && Reveal.getScale) ? Reveal.getScale() : 1;
    var out = {};
    document.querySelectorAll('.reveal .slides > section').forEach(function(top){
      var slides = top.tagName === 'SECTION' && top.querySelector(':scope > section')
        ? top.querySelectorAll(':scope > section') : [top];
      slides.forEach(function(sec){
        var id = sec.id || '(no-id)';
        var els = [];
        // direct children only, plus one level of nested structure (columns,
        // divs) so the report shows the tree that matters for layout
        function walk(node, depth){
          if (depth > 4) return;
          Array.prototype.forEach.call(node.children, function(el){
            if (el.tagName === 'STYLE' || el.tagName === 'SCRIPT') return;
            var r = el.getBoundingClientRect();
            if (r.width <= 0 && r.height <= 0) return;
            var cls = (el.className && typeof el.className === 'string')
              ? el.className.split(' ').filter(Boolean).slice(0, 3).join('.') : '';
            els.push({
              d: depth,
              tag: el.tagName.toLowerCase() + (cls ? '.' + cls : ''),
              top: Math.round(r.top / rs), h: Math.round(r.height / rs),
              w: Math.round(r.width / rs), sh: el.scrollHeight,
              text: (el.textContent || '').trim().replace(/\s+/g, ' ').slice(0, 50)
            });
            walk(el, depth + 1);
          });
        }
        walk(sec, 0);
        out[id] = {
          title: (sec.querySelector('h1,h2,h3') || {}).textContent || '',
          sh: sec.scrollHeight, ch: sec.clientHeight,
          oy: getComputedStyle(sec).overflowY,
          frag: sec.querySelectorAll('.fragment').length,
          els: els.sort(function(a, b){ return (b.top + b.h) - (a.top + a.h); })
        };
      });
    });
    window.__SLIDES__ = out;
    fetch('http://127.0.0.1:__PORT__/done', {method: 'POST', body: JSON.stringify(out)});
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
    // Escape threshold must stay WELL below the virtual-time budget (see
    // check_overflow.py); stable>=4 fires almost immediately.
    if ((stable >= 4 && tries > 20) || tries > 200) { measure(); return; }
    setTimeout(poll, 150);
  }
  setTimeout(poll, 800);
})();
</script>
"""


def find_chrome():
    # Prefer chrome-headless-shell: plain chrome.exe intermittently hands
    # off to the user's running browser when launched from an elevated
    # shell (exits in ~0.1s, page never loads) — see check_overflow.py.
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
    def do_GET(self):
        if self.path.startswith("/?"):
            self.server.payload = urllib.parse.unquote(self.path[2:])
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(b"ok")

    def do_POST(self):
        # POST transport: payloads (per-element dumps) can exceed the
        # request-line length limit that breaks GET query strings.
        length = int(self.headers.get("Content-Length", 0))
        self.server.payload = self.rfile.read(length).decode("utf-8")
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(b"ok")

    def log_message(self, *args):
        pass


def collect(html_path, chrome_bin, attempts=4):
    """Run the deck in headless Chrome; retries (launches are flaky when
    the shell is elevated — see check_overflow.py)."""
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
    base = os.path.basename(html_path)
    tmp_name = os.path.join(
        os.path.dirname(os.path.abspath(html_path)),
        f".{base}.dump-{os.getpid()}.html")
    with open(tmp_name, "w", encoding="utf-8") as f:
        f.write(content.replace(
            "</body>", MEASURE_SCRIPT.replace("__PORT__", str(port)) + "</body>"))
    import pathlib
    url = pathlib.Path(tmp_name).as_uri()

    shot = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
    shot.close()
    profile = tempfile.mkdtemp(prefix="dump-profile-")
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


def matches(slide_id, patterns):
    return any(slide_id == p or slide_id.startswith(p) for p in patterns)


def print_slide(name, info):
    flag = "OVERFLOW" if (info["sh"] > info["ch"]
                          and info["oy"] in ("auto", "scroll")) else "ok"
    print(f"\n=== {name} — {info['title'].strip()} [{flag}] "
          f"sh={info['sh']} ch={info['ch']} frag={info['frag']}")
    bottom = info["ch"]
    for e in info["els"]:
        edge = e["top"] + e["h"]
        marker = ""
        if edge > bottom and e["d"] == 0:
            marker = f"  <-- bottom {edge} > {bottom}"
        pad = "  " * e["d"]
        text = f" | {e['text']}" if e["text"] else ""
        print(f"{pad}{'  '*1}top={e['top']:>4} h={e['h']:>4} w={e['w']:>4} "
              f"sh={e['sh']:>4}  {e['tag']}{text}{marker}")


def main():
    # Windows consoles default to a legacy codepage; slide text contains
    # typographic characters that crash print() without this.
    if sys.stdout.encoding and sys.stdout.encoding.lower() not in ("utf-8", "utf8"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("html", help="rendered deck .html")
    ap.add_argument("slides", nargs="*",
                    help="slide id or id prefix (e.g. density-undirected)")
    ap.add_argument("--overflow", action="store_true",
                    help="dump only slides that overflow")
    ap.add_argument("--all", action="store_true", help="dump every slide")
    args = ap.parse_args()

    if not args.slides and not args.overflow and not args.all:
        ap.error("give slide ids, or --overflow / --all")

    chrome = find_chrome()
    if chrome is None:
        print("[ERROR] No headless-capable Chrome found. Set CHROME_BIN.",
              flush=True)
        return 1
    data = collect(args.html, chrome)
    if data is None:
        print("[ERROR] no measurements received from headless Chrome")
        return 1

    wanted = []
    for sid, info in data.items():
        over = info["sh"] > info["ch"] and info["oy"] in ("auto", "scroll")
        if args.all or (args.overflow and over) or matches(sid, args.slides):
            wanted.append((sid, info))
    if not wanted:
        print("No slides matched. Available ids:")
        for sid, info in data.items():
            print(f"  {sid}  — {info['title'].strip()[:70]}")
        return 1
    for sid, info in wanted:
        print_slide(sid, info)
    return 0


if __name__ == "__main__":
    sys.exit(main())
