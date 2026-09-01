/// Step 14 widget tests — selection, the session list, and the live chat,
/// all against a MOCKED chat repository. No server, no model calls.
library;

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart' hide Evaluation;
import 'package:go_router/go_router.dart';

import 'package:dating_app_ux/core/api/api_client.dart';
import 'package:dating_app_ux/core/auth/auth_controller.dart';
import 'package:dating_app_ux/features/analyses/analyses_repository.dart';
import 'package:dating_app_ux/features/analyses/models.dart';
import 'package:dating_app_ux/features/auth/models.dart';
import 'package:dating_app_ux/features/chat/chat_list_screen.dart';
import 'package:dating_app_ux/features/chat/chat_repository.dart';
import 'package:dating_app_ux/features/chat/chat_screen.dart';
import 'package:dating_app_ux/features/chat/chat_widget.dart';
import 'package:dating_app_ux/features/chat/models.dart';
import 'package:dating_app_ux/features/dates/dates_repository.dart';
import 'package:dating_app_ux/features/dates/models.dart';
import 'package:dating_app_ux/features/dates/results_screen.dart';

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

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

Candidate _candidate(String id, String name, {double? score, bool demo = false}) =>
    Candidate(
      candidateUserId: id,
      displayName: name,
      age: 34,
      isDemo: demo,
      traitLabels: const {'interest': ['restores old bicycles']},
      rank: 1,
      fitForward: 0.8,
      fitBackward: 0.7,
      compatibility: 0.75,
      sharedInterests: const ['bicycles'],
      reasonSummary: 'You both restore bicycles.',
      snapshotId: 's1',
      finalScore: score,
    );

final _analysis = Analysis(
  id: 'a1',
  status: 'complete',
  poolStatus: 'full',
  createdAt: '2026-09-01T10:00:00',
  progress: const {'stage': 'done', 'judged': true, 'message': 'Done.'},
  candidates: [
    _candidate('dan', 'Dan', score: 94.25, demo: true),
    _candidate('bob', 'Bob', score: 86.5),
  ],
);

const _danMatch = ChatMatch(userId: 'dan', displayName: 'Dan', isDemo: true);

final _session = ChatSessionSummary(
  sessionId: 's-dan',
  analysisId: 'a1',
  match: _danMatch,
  status: 'active',
  createdAt: '2026-09-01T11:00:00',
);

const _detail = ChatSessionDetail(
  sessionId: 's-dan',
  analysisId: 'a1',
  match: _danMatch,
  status: 'active',
  traitLabels: {'interest': ['restores old bicycles']},
  dateDigest: 'At the Vintage Bike Exhibition: you got on.',
  snapshotId: 'snap-1',
);

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

class _FakeChat extends ChatRepository {
  _FakeChat() : super(Dio());

  final List<ChatSessionSummary> sessionsList = [];
  ChatSessionDetail detailValue = _detail;
  final List<ChatMessageModel> history = [];
  int selectCalls = 0;
  int endCalls = 0;
  int seq = 0;

  /// Set to make the next `select` answer 409 already_selected.
  String? alreadySelectedId;

  /// Set to make the next `send` fail with the server's give-up.
  bool failNextSend = false;

  /// When set, `send` waits on it — lets a test look at the in-flight state.
  Completer<void>? hold;

  @override
  Future<ChatSessionSummary> select(String analysisId, String candidateUserId) async {
    selectCalls++;
    if (alreadySelectedId != null) throw AlreadySelected(alreadySelectedId);
    final s = _session.copyWith(analysisId: analysisId);
    sessionsList.add(s);
    return s;
  }

  @override
  Future<List<ChatSessionSummary>> sessions() async => List.of(sessionsList);

  @override
  Future<ChatSessionDetail> detail(String sessionId) async => detailValue;

  @override
  Future<MessagesPage> messages(String sessionId, {int afterSeq = 0}) async =>
      MessagesPage(messages: history.where((m) => m.seq > afterSeq).toList());

  @override
  Future<ReplyResult> send(String sessionId, String text) async {
    if (hold != null) await hold!.future;
    if (failNextSend) {
      failNextSend = false;
      throw const ApiException(
        code: 'reply_failed',
        message: "They couldn't reply just now. Your message is still in the box — try sending it again.",
        status: 502,
      );
    }
    final user = ChatMessageModel(messageId: 'm${++seq}', seq: seq, sender: 'user', text: text);
    final persona = ChatMessageModel(
        messageId: 'm${++seq}', seq: seq, sender: 'persona', text: 'Reply to: $text');
    history..add(user)..add(persona);
    return ReplyResult(userMessage: user, personaMessage: persona);
  }

  @override
  Future<ChatSessionSummary> end(String sessionId) async {
    endCalls++;
    final i = sessionsList.indexWhere((s) => s.sessionId == sessionId);
    final ended = (i >= 0 ? sessionsList[i] : _session).copyWith(status: 'ended');
    if (i >= 0) sessionsList[i] = ended;
    detailValue = detailValue.copyWith(status: 'ended');
    return ended;
  }
}

class _FakeAnalyses extends AnalysesRepository {
  _FakeAnalyses() : super(Dio());

  @override
  Future<Analysis> get(String id) async => _analysis;

  @override
  Future<List<Analysis>> history() async => [_analysis];
}

class _FakeDates extends DatesRepository {
  _FakeDates() : super(Dio());

  @override
  Future<DatesPayload> dates(String analysisId) async =>
      const DatesPayload(analysisId: 'a1', status: 'complete', dates: []);
}

class _SignedIn extends AuthController {
  @override
  Future<User?> build() async => _me;
}

GoRouter _router(String initial) => GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold(body: Text('home'))),
        GoRoute(
            path: '/profile/expand',
            builder: (_, _) => const Scaffold(body: Text('expand'))),
        GoRoute(
          path: '/analyses/:id',
          builder: (_, _) => const Scaffold(body: Text('analysis')),
          routes: [
            GoRoute(
              path: 'results',
              builder: (_, s) => ResultsScreen(analysisId: s.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(path: '/chat', builder: (_, _) => const ChatListScreen()),
        GoRoute(
          path: '/chat/:sessionId',
          builder: (_, s) => ChatScreen(sessionId: s.pathParameters['sessionId']!),
        ),
      ],
    );

Future<void> _pump(WidgetTester tester, String initial, _FakeChat chat) async {
  tester.view.physicalSize = const Size(800, 3000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(_SignedIn.new),
      analysesRepositoryProvider.overrideWithValue(_FakeAnalyses()),
      datesRepositoryProvider.overrideWithValue(_FakeDates()),
      chatRepositoryProvider.overrideWithValue(chat),
    ],
    child: MaterialApp.router(routerConfig: _router(initial)),
  ));
}

void main() {
  // -------------------------------------------------------------------------
  // Selection (S14-U1, U2; AC1)
  // -------------------------------------------------------------------------

  testWidgets('choose → confirm sheet with the two lines → one session → chat',
      (tester) async {
    final chat = _FakeChat();
    await _pump(tester, '/analyses/a1/results', chat);
    await tester.pumpAndSettle();

    expect(find.text('Choose Dan'), findsOneWidget);
    expect(find.text('Choose Bob'), findsOneWidget);

    await tester.tap(find.text('Choose Dan'));
    await tester.pumpAndSettle();
    // The deal, in two lines, where the not-notified honesty has to land.
    expect(
        find.text("You'll chat with an AI version of Dan that remembers your simulated dates."),
        findsOneWidget);
    expect(
        find.text("Dan won't be notified — real conversations aren't part of this phase."),
        findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Choose Dan').last);
    await tester.pumpAndSettle();
    expect(chat.selectCalls, 1);
    expect(find.byType(ChatScreen), findsOneWidget);
    expect(find.text('AI persona'), findsWidgets);

    // Back on the results: the constraint is visible, not hidden (S14-U2).
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Open the chat'), findsOneWidget);
    expect(find.text('already chose Dan'), findsOneWidget);
    expect(find.text('Choose Bob'), findsNothing);
    final disabled = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, 'already chose Dan'));
    expect(disabled.onPressed, isNull);
  });

  testWidgets('a 409 already_selected is state: it opens the existing chat',
      (tester) async {
    final chat = _FakeChat()..alreadySelectedId = 's-dan';
    await _pump(tester, '/analyses/a1/results', chat);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choose Bob'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Choose Bob').last);
    await tester.pumpAndSettle();
    expect(find.byType(ChatScreen), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
  });

  // -------------------------------------------------------------------------
  // The chat (S14-U4..U7; AC5, AC8)
  // -------------------------------------------------------------------------

  testWidgets('send: user bubble at once, typing indicator, reply lands; '
      'no metadata, no flagging', (tester) async {
    final chat = _FakeChat()..hold = Completer<void>();
    await _pump(tester, '/chat/s-dan', chat);
    await tester.pumpAndSettle();

    expect(find.textContaining('This is an AI version of Dan'), findsOneWidget);
    final config = tester.widget<ChatView>(find.byType(ChatView)).config;
    expect(config.allowFlagging, isFalse); // AC8: the other configuration
    expect(config.showMetadata, isFalse);

    await tester.enterText(find.byType(TextField), 'Hello Dan');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // S14-U7: the user bubble immediately; the persona side never before it lands.
    expect(find.text('Hello Dan'), findsOneWidget);
    expect(find.text('Dan is typing…'), findsOneWidget);
    expect(find.text('Reply to: Hello Dan'), findsNothing);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.enabled, isFalse); // strictly sequential

    chat.hold!.complete();
    await tester.pumpAndSettle();
    expect(find.text('Dan is typing…'), findsNothing);
    expect(find.text('Reply to: Hello Dan'), findsOneWidget);
    expect(find.byIcon(Icons.flag), findsNothing);
    expect(find.textContaining('connection'), findsNothing);
  });

  testWidgets("server give-up: explicit notice in-thread, text kept, retry works",
      (tester) async {
    final chat = _FakeChat()..failNextSend = true;
    await _pump(tester, '/chat/s-dan', chat);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Are you there?');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    // AC5: the explicit sentence, in-thread — never a degraded reply.
    expect(find.textContaining("They couldn't reply just now"), findsOneWidget);
    expect(find.textContaining('Reply to:'), findsNothing);
    // The user's text survives in the composer, marked unsent.
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'Are you there?');
    expect(find.textContaining('Not sent yet'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();
    expect(find.text('Reply to: Are you there?'), findsOneWidget);
    expect(find.textContaining("They couldn't reply just now"), findsNothing);
    expect(find.textContaining('Not sent yet'), findsNothing);
  });

  testWidgets('header tap opens the sheet: traits, digest, transcripts link',
      (tester) async {
    final chat = _FakeChat();
    await _pump(tester, '/chat/s-dan', chat);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dan'));
    await tester.pumpAndSettle();
    expect(find.text('At the Vintage Bike Exhibition: you got on.'), findsOneWidget);
    expect(find.text('restores old bicycles'), findsOneWidget);
    expect(find.text('Read the original transcripts'), findsOneWidget);
  });

  // -------------------------------------------------------------------------
  // Ending, and the list (S14-U3, U9; AC6)
  // -------------------------------------------------------------------------

  testWidgets('end chat: confirm, composer goes, history stays, list shows Ended',
      (tester) async {
    final chat = _FakeChat()..sessionsList.add(_session);
    chat.history.addAll(const [
      ChatMessageModel(messageId: 'm1', seq: 1, sender: 'user', text: 'Hi'),
      ChatMessageModel(messageId: 'm2', seq: 2, sender: 'persona', text: 'Hey.'),
    ]);
    await _pump(tester, '/chat/s-dan', chat);
    await tester.pumpAndSettle();
    expect(find.text('Hey.'), findsOneWidget);

    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('End chat'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'End chat'));
    await tester.pumpAndSettle();

    expect(chat.endCalls, 1);
    expect(find.text('This chat has ended. You can still read it.'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Hey.'), findsOneWidget); // readable

    // The list: it moved to Ended.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.byType(ChatListScreen), findsOneWidget);
    expect(find.text('Ended'), findsOneWidget);
    expect(find.text('Active'), findsNothing);
    expect(find.text('Demo'), findsOneWidget); // the chip survives onto the list
  });

  testWidgets('the list: active first, then ended; empty state points home',
      (tester) async {
    final chat = _FakeChat()
      ..sessionsList.addAll([
        _session.copyWith(sessionId: 's-old', status: 'ended',
            match: const ChatMatch(userId: 'bob', displayName: 'Bob', isDemo: false)),
        _session,
      ]);
    await _pump(tester, '/chat', chat);
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.text('Dan')).dy,
        lessThan(tester.getTopLeft(find.text('Bob')).dy));

    final empty = _FakeChat();
    await _pump(tester, '/chat', empty);
    await tester.pumpAndSettle();
    expect(find.textContaining('No chats yet'), findsOneWidget);
  });
}
