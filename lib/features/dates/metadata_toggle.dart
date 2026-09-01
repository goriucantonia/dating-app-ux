import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/auth/auth_controller.dart';

/// The transcript viewer's metadata toggle (S13-U7), app-wide and persisted
/// PER USER. Default **on**: the inner state is the spectacle and the reason
/// the transcript endpoint exposes it at all (decision log #4).
///
/// It is one of the flags §8 names: both settings have to be observed doing
/// something different, and the setting has to survive a restart (AC3). It
/// lives in `shared_preferences` rather than the token store on purpose —
/// signing out wipes the token store, and a preference is not a session.
///
/// Storage failure (a browser blocking site data, a missing platform store)
/// falls back to the default in memory: the toggle still works for this run,
/// it just does not survive the restart. Never an exception into UI code.
class MetadataToggle extends AsyncNotifier<bool> {
  static const _prefix = 'transcript_metadata.';

  String _key(String? userId) => '$_prefix${userId ?? 'anonymous'}';

  @override
  Future<bool> build() async {
    final userId = ref.watch(authControllerProvider).valueOrNull?.id;
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_key(userId)) ?? true;
    } catch (_) {
      return true;
    }
  }

  Future<void> set(bool value) async {
    state = AsyncData(value);
    final userId = ref.read(authControllerProvider).valueOrNull?.id;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key(userId), value);
    } catch (_) {
      // In-memory only for this run.
    }
  }

  Future<void> toggle() => set(!(state.valueOrNull ?? true));
}

final metadataToggleProvider =
    AsyncNotifierProvider<MetadataToggle, bool>(MetadataToggle.new);
