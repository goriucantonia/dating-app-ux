import 'package:go_router/go_router.dart';

import '../features/debug/health_screen.dart';

/// go_router setup. Step 1 has exactly one screen — the throwaway health
/// check (S1-U6, retired in Step 4). Typed routes and the two guards
/// (auth, baseline-questionnaire) arrive in Steps 4–5 and live HERE, in one
/// place (§16).
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HealthScreen(),
    ),
  ],
);
