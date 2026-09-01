"""Serve `build/web` with an SPA fallback, for witnessing the UI locally.

Why this exists rather than `python -m http.server`: the app uses path-based
URLs (`/analyses/<id>`), so a reload or a pasted deep link asks the server for
a path that is not a file. `http.server` answers 404 and the app never boots —
which looks exactly like a broken deep link but is a missing server rule.
Anything hosting this app for real needs the same fallback.

Not part of the app, and not a production server. It is the harness that makes
the deep-link acceptance criteria (S10-U13, AC1) checkable at all.

    python serve_build.py [port]
"""

from __future__ import annotations

import sys
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

ROOT = Path(__file__).parent / "build" / "web"


class SpaHandler(SimpleHTTPRequestHandler):
    def do_GET(self) -> None:  # noqa: N802 — stdlib naming
        candidate = ROOT / self.path.lstrip("/").split("?")[0]
        if self.path != "/" and not candidate.is_file():
            # Any path that is not a real file is a client route.
            self.path = "/index.html"
        super().do_GET()

    def log_message(self, *args) -> None:
        pass  # quiet: the point of the run is the browser, not this


if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 5000
    handler = partial(SpaHandler, directory=str(ROOT))
    print(f"serving {ROOT} on http://127.0.0.1:{port} (SPA fallback on)")
    ThreadingHTTPServer(("127.0.0.1", port), handler).serve_forever()
