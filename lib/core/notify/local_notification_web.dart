import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Browsers only grant notification permission from a user gesture, so this
/// is called from the "Start Simulated Dates" tap — the one moment the user
/// is telling us they intend to walk away and come back.
Future<void> requestNotificationPermission() async {
  try {
    if (web.Notification.permission == 'default') {
      await web.Notification.requestPermission().toDart;
    }
  } catch (_) {
    // No Notification API (old browser, insecure context): the in-app
    // banner is the fallback and it always fires.
  }
}

/// A LOCAL notification (S13-U4): there is no push channel from the server
/// (`communication_protocol.md` §1). This fires from the client's own poller
/// when it sees the analysis flip to `complete`.
Future<void> notifyLocal({required String title, required String body}) async {
  try {
    if (web.Notification.permission != 'granted') return;
    web.Notification(title, web.NotificationOptions(body: body));
  } catch (_) {}
}
