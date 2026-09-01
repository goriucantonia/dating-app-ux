import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/auth_repository.dart';
import '../../features/auth/models.dart';
import '../api/api_client.dart';
import 'token_store.dart';

/// The app-wide auth state: `null` = signed out, a [User] = signed in.
/// Restoring the session from secure storage happens once in [build] — the
/// "kill the app, reopen, still signed in" behavior lives here (Step 4 AC4).
class AuthController extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final store = ref.read(tokenStoreProvider);
    await store.load();
    if (store.token == null) return null;
    try {
      return await ref.read(authRepositoryProvider).me();
    } on ApiException catch (e) {
      if (e.status == 401) {
        await store.clear();
        return null; // dead session: land on /login, not an error screen
      }
      rethrow; // server unreachable etc. — surfaced, not swallowed
    }
  }

  Future<void> logIn(String email, String password) async {
    final result = await ref.read(authRepositoryProvider).login(email, password);
    await ref.read(tokenStoreProvider).save(result.token);
    state = AsyncData(result.user);
  }

  Future<void> registerAccount(RegisterData data) async {
    final result = await ref.read(authRepositoryProvider).register(data);
    await ref.read(tokenStoreProvider).save(result.token);
    state = AsyncData(result.user);
  }

  Future<void> logOut() async {
    await ref.read(tokenStoreProvider).clear();
    state = const AsyncData(null);
  }

  /// Called by the ONE dio interceptor on any 401 — the session is dead.
  void sessionExpired() {
    ref.read(tokenStoreProvider).clear();
    state = const AsyncData(null);
  }
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, User?>(AuthController.new);
