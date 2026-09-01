import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/auth/auth_controller.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/questions/expand_screen.dart';
import '../features/questions/onboarding_screen.dart';
import '../features/questions/questions_providers.dart';

/// go_router with BOTH guards in this ONE place (§16, ux_architecture.md §1.2):
/// 1. unauthenticated → /login
/// 2. signed in with unanswered baseline questions → /onboarding/questions —
///    the "nothing works without it" gate.
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier(0);
  ref.listen(authControllerProvider, (_, _) => refresh.value++);
  ref.listen(questionsProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      if (auth.isLoading) return null; // '/' renders a spinner meanwhile
      final signedIn = auth.valueOrNull != null;
      final location = state.matchedLocation;
      final onAuthPage = location == '/login' || location == '/register';

      if (!signedIn) return onAuthPage ? null : '/login';
      if (onAuthPage) return '/';

      // Guard 2 — null means "not known yet": never bounce on a guess.
      final incomplete = baselineIncomplete(ref.read(questionsProvider));
      if (incomplete == true && location != '/onboarding/questions') {
        return '/onboarding/questions';
      }
      if (incomplete == false && location == '/onboarding/questions') {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
      GoRoute(
          path: '/onboarding/questions',
          builder: (_, _) => const OnboardingQuestionsScreen()),
      GoRoute(
          path: '/profile/expand', builder: (_, _) => const ExpandScreen()),
    ],
  );
});
