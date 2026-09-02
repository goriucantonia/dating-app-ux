import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/auth/auth_controller.dart';
import 'nav_shell.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/chat/chat_list_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/home/home_screen.dart';
import '../features/questions/correction_screen.dart';
import '../features/questions/expand_screen.dart';
import '../features/analyses/analysis_screen.dart';
import '../features/dates/results_screen.dart';
import '../features/dates/transcript_screen.dart';
import '../features/persona/building_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/traits/calibration_screen.dart';
import '../features/traits/profile_screen.dart';
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
      // The building screen is the step immediately AFTER the last answer.
      // It must be reachable while the provider still reports the old
      // "incomplete" value, or the guard would bounce the user back to a
      // questionnaire they just finished.
      if (incomplete == true &&
          location != '/onboarding/questions' &&
          location != '/onboarding/building') {
        return '/onboarding/questions';
      }
      if (incomplete == false && location == '/onboarding/questions') {
        return '/';
      }
      return null;
    },
    routes: [
      // Outside the shell: the three screens where a navigation bar would be
      // an invitation to leave something half-finished.
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
      GoRoute(
          path: '/onboarding/questions',
          builder: (_, _) => const OnboardingQuestionsScreen()),
      GoRoute(
          path: '/onboarding/building',
          builder: (_, _) => const BuildingScreen()),

      // S18-U1: everything else lives under the ONE persistent navigation,
      // four branches, each with its own stack. A screen nested under a
      // branch keeps the bar AND gets a working back button — the two things
      // the old flat route list had neither of.
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => NavShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/',
              builder: (_, _) => const HomeScreen(),
              routes: [
                // S10-U7/U13: ONE route, phase-switched by the analysis
                // status, so a deep link lands correctly whatever phase the
                // run is in.
                GoRoute(
                  path: 'analyses/:id',
                  builder: (_, state) =>
                      AnalysisScreen(analysisId: state.pathParameters['id']!),
                  routes: [
                    // S13-U10: the results dashboard.
                    GoRoute(
                      path: 'results',
                      builder: (_, state) =>
                          ResultsScreen(analysisId: state.pathParameters['id']!),
                    ),
                  ],
                ),
                // S13-U6/U9: the transcript viewer, with `?seq=` as its anchor.
                GoRoute(
                  path: 'dates/:id',
                  builder: (_, state) => TranscriptScreen(
                    dateId: state.pathParameters['id']!,
                    anchorSeq:
                        int.tryParse(state.uri.queryParameters['seq'] ?? ''),
                  ),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              builder: (_, _) => const ProfileScreen(),
              routes: [
                GoRoute(
                    path: 'calibration',
                    builder: (_, _) => const CalibrationScreen()),
                GoRoute(path: 'expand', builder: (_, _) => const ExpandScreen()),
                // S18-U3: the disputed trait's own question, answered on its
                // own screen. It used to be "somewhere in /profile/expand",
                // which is to say nowhere.
                GoRoute(
                  path: 'correct/:questionId',
                  builder: (_, state) => CorrectionScreen(
                      questionId: state.pathParameters['questionId']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/chat',
              builder: (_, _) => const ChatListScreen(),
              routes: [
                GoRoute(
                  path: ':sessionId',
                  builder: (_, state) => ChatScreen(
                      sessionId: state.pathParameters['sessionId']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
          ]),
        ],
      ),
    ],
  );
});
