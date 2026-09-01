// One import for "tell the user, even if the app is in another tab".
//
// Web gets the browser's Notification API; everything else is a no-op for
// now and relies on the in-app banner (see `completion.dart`). Conditional
// import rather than a runtime `kIsWeb` branch so the non-web build never
// even links `package:web`.
export 'local_notification_stub.dart'
    if (dart.library.js_interop) 'local_notification_web.dart';
