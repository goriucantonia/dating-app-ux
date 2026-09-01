/// Step 15 widget tests — deletion with its receipt, and the tombstones —
/// against MOCKED repositories.
library;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart' hide Evaluation;
import 'package:go_router/go_router.dart';

import 'package:dating_app_ux/core/api/api_client.dart';
import 'package:dating_app_ux/core/auth/auth_controller.dart';
import 'package:dating_app_ux/features/analyses/analyses_repository.dart';
import 'package:dating_app_ux/features/analyses/analysis_screen.dart';
import 'package:dating_app_ux/features/analyses/models.dart';
import 'package:dating_app_ux/features/auth/auth_repository.dart';
import 'package:dating_app_ux/features/auth/models.dart';
import 'package:dating_app_ux/features/chat/chat_repository.dart';
import 'package:dating_app_ux/features/chat/chat_screen.dart';
import 'package:dating_app_ux/features/chat/models.dart';
import 'package:dating_app_ux/features/dates/dates_repository.dart';
import 'package:dating_app_ux/features/dates/models.dart';
import 'package:dating_app_ux/features/home/home_screen.dart';
import 'package:dating_app_ux/features/questions/models.dart';
import 'package:dating_app_ux/features/questions/questions_providers.dart';
import 'package:dating_app_ux/features/settings/settings_screen.dart';

const _me = User(
  id: 'u1',
  email: 'me@example.com',
  displayName: 'Alice',
  birthDate: '1990-01-01',
  age: 36,
  gender: 'female',
  interestedIn: ['male'],
  agePrefMin: 25,
  agePrefMax: 45,
  optIn: true,
  isDemo: false,
);

final _analysisWithGap = Analysis(
  id: 'a1',
  status: 'complete',
  poolStatus: 'full',
  createdAt: '2026-09-01T10:00:00',
  progress: const {'stage': 'done', 'judged': true, 'message': 'Done.'},
  removedCandidates: 1,
  candidates: const [
    Candidate(
      candidateUserId: 'bob',
      displayName: 'Bob',
      age: 34,
      isDemo: false,
      traitLabels: {},
      rank: 1,
      fitForward: 0.8,
      fitBackward: 0.7,
      compatibility: 0.75,
      sharedInterests: [],
      reasonSummary: 'You fit.',
      snapshotId: 's1',
      finalScore: 80,
    ),
  ],
);

class _FakeAuth extends AuthRepository {
  _FakeAuth() : super(Dio());
  int deleteCalls = 0;

  @override
  Future<DeletionReceipt> deleteMe() async {
    deleteCalls++;
    return const DeletionReceipt(
      deleted: {'answers': 35, 'traits': 9, 'dates_as_candidate': 2, 'chat_messages': 0},
      rowsRemoved: 46,
    );
  }
}

class _Auth extends AuthController {
  bool loggedOut = false;

  @override
  Future<User?> build() async => _me;

  @override
  Future<void> logOut() async {
    loggedOut = true;
    state = const AsyncData(null);
  }
}

class _FakeAnalyses extends AnalysesRepository {
  _FakeAnalyses() : super(Dio());

  @override
  Future<Analysis> get(String id) async => _analysisWithGap;

  @override
  Future<List<Analysis>> history() async => [_analysisWithGap];
}

class _FakeDates extends DatesRepository {
  _FakeDates() : super(Dio());

  @override
  Future<DatesPayload> dates(String analysisId) async =>
      const DatesPayload(analysisId: 'a1', status: 'complete', dates: []);
}

class _GoneChat extends ChatRepository {
  _GoneChat() : super(Dio());

  @override
  Future<ChatSessionDetail> detail(String sessionId) async =>
      throw const ApiException(code: 'not_found', message: "That chat doesn't exist.", status: 404);

  @override
  Future<List<ChatSessionSummary>> sessions() async => [];
}

class _Questions extends QuestionsController {
  @override
  Future<List<Question>> build() async => const [];
}

GoRouter _router(String initial) => GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
        GoRoute(path: '/login', builder: (_, _) => const Scaffold(body: Text('login'))),
        GoRoute(path: '/profile', builder: (_, _) => const Scaffold(body: Text('profile'))),
        GoRoute(path: '/chat', builder: (_, _) => const Scaffold(body: Text('chats'))),
        GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
        GoRoute(
          path: '/analyses/:id',
          builder: (_, s) => AnalysisScreen(analysisId: s.pathParameters['id']!),
        ),
        GoRoute(
          path: '/chat/:sessionId',
          builder: (_, s) => ChatScreen(sessionId: s.pathParameters['sessionId']!),
        ),
      ],
    );

Future<({_FakeAuth auth, _Auth controller})> _pump(
    WidgetTester tester, String initial) async {
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final auth = _FakeAuth();
  final controller = _Auth();
  await tester.pumpWidget(ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(() => controller),
      authRepositoryProvider.overrideWithValue(auth),
      analysesRepositoryProvider.overrideWithValue(_FakeAnalyses()),
      datesRepositoryProvider.overrideWithValue(_FakeDates()),
      chatRepositoryProvider.overrideWithValue(_GoneChat()),
      questionsProvider.overrideWith(_Questions.new),
    ],
    child: MaterialApp.router(routerConfig: _router(initial)),
  ));
  return (auth: auth, controller: controller);
}

void main() {
  testWidgets('delete account: two confirms, the receipt, then sign-out',
      (tester) async {
    final f = await _pump(tester, '/settings');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete my account'));
    await tester.pumpAndSettle();
    expect(find.text('Delete your account?'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    // The cross-user effect, in plain words, before the irreversible tap.
    expect(find.textContaining('disappear from your friends’ results too'),
        findsOneWidget);
    expect(f.auth.deleteCalls, 0);

    await tester.tap(find.text('Yes, delete everything'));
    await tester.pumpAndSettle();
    expect(f.auth.deleteCalls, 1);
    // The receipt is the server's own counts.
    expect(find.text('Your account is gone'), findsOneWidget);
    expect(find.text('46 rows were removed:'), findsOneWidget);
    expect(find.text('35 × answers'), findsOneWidget);
    expect(find.text('2 × dates as candidate'), findsOneWidget);
    expect(find.textContaining('chat messages'), findsNothing); // zero rows are not listed
    expect(f.controller.loggedOut, isFalse); // not before the receipt is read

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(f.controller.loggedOut, isTrue);
  });

  testWidgets('backing out of either confirm deletes nothing', (tester) async {
    final f = await _pump(tester, '/settings');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete my account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Keep my account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete my account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('No, keep it'));
    await tester.pumpAndSettle();
    expect(f.auth.deleteCalls, 0);
    expect(f.controller.loggedOut, isFalse);
  });

  testWidgets('tombstones: the dashboard row and the analysis name the gap',
      (tester) async {
    await _pump(tester, '/');
    await tester.pumpAndSettle();
    expect(find.text('One person in this analysis removed their account.'),
        findsWidgets);

    await tester.tap(find.text('Bob, 34').first);
    await tester.pumpAndSettle();
    expect(find.byType(AnalysisScreen), findsOneWidget);
    expect(find.text('One person in this analysis removed their account.'),
        findsOneWidget);
    expect(find.textContaining('Their dates and scores went with them'),
        findsOneWidget);
  });

  testWidgets('a vanished chat explains rather than erroring', (tester) async {
    await _pump(tester, '/chat/s-gone');
    await tester.pumpAndSettle();
    expect(find.textContaining('This person removed their account'), findsOneWidget);
    expect(find.text('Back to your chats'), findsOneWidget);
    expect(find.text('Try again'), findsNothing);
  });
}
