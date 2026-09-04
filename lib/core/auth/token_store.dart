import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// JWT persistence (S4-U2): flutter_secure_storage — Keychain/Keystore on
/// mobile, DPAPI on Windows, WebCrypto-encrypted localStorage on web
/// (ux_architecture.md §1.3). An in-memory copy backs the synchronous read
/// the request interceptor needs.
class TokenStore {
  static const _storage = FlutterSecureStorage();
  static const _key = 'jwt';

  String? _cached;

  /// Synchronous read for the dio interceptor; valid after [load].
  String? get token => _cached;

  /// Storage failures (corrupted data, blocked browser storage, missing
  /// platform keystore) must never take the app down or silently eat a
  /// sign-in: reads fall back to "no session", writes fall back to the
  /// in-memory copy (the session then just doesn't survive a restart).
  Future<String?> load() async {
    try {
      _cached = await _storage.read(key: _key);
    } catch (_) {
      _cached = null;
      await clear(); // drop whatever is corrupted so the next save is clean
    }
    return _cached;
  }

  Future<void> save(String token) async {
    _cached = token;
    try {
      await _storage.write(key: _key, value: token);
    } catch (_) {
      // Signed in for this run only; a restart will ask to sign in again.
    }
  }

  Future<void> clear() async {
    _cached = null;
    try {
      await _storage.delete(key: _key);
    } catch (_) {}
  }
}

final tokenStoreProvider = Provider<TokenStore>((ref) => TokenStore());
