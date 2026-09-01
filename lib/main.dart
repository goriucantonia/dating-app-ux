import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/app.dart';

void main() {
  // Path URLs, not hash URLs (S10-U13, AC1).
  //
  // Flutter web defaults to the hash strategy, where the router only ever sees
  // the part after `#`. A deep link like `/analyses/<id>` then reaches the
  // browser correctly, the server serves it correctly — and go_router still
  // starts at `/`, because as far as it is concerned the route was empty. The
  // symptom looks exactly like a broken deep link and is nothing of the kind,
  // which is why PICKUP carried it as an open question from Step 5 until this
  // step needed deep links to actually work.
  //
  // This is a no-op off the web. Its server-side counterpart is the SPA
  // fallback (see `serve_build.py`): both halves are required, and each one
  // alone looks like the other one is broken.
  usePathUrlStrategy();
  runApp(const ProviderScope(child: App()));
}
