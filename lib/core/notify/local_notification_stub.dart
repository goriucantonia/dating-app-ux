/// Non-web platforms: no OS notification this phase. The in-app banner still
/// fires (S13-U4), so nothing is silently lost — the OS-level channel on
/// desktop/mobile needs a plugin and is written up in PICKUP as owed.
Future<void> requestNotificationPermission() async {}

Future<void> notifyLocal({required String title, required String body}) async {}
