/// Step 13 widget tests — every screen driven by MOCKED repositories, no
/// server, no model calls. The fixtures are shaped like real stored data
/// (a judged date, a partial one at half weight, an excluded one under the
/// 10-turn rule, a transcript with an environment row), so what the tests
/// pin is the arithmetic and the honesty rules, not a happy path.
library;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart' hide Evaluation;
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dating_app_ux/core/auth/auth_controller.dart';
import 'package:dating_app_ux/core/notify/completion.dart';
import 'package:dating_app_ux/core/polling/poller.dart';
import 'package:dating_app_ux/features/analyses/analyses_repository.dart';
import 'package:dating_app_ux/features/analyses/analysis_screen.dart';
import 'package:dating_app_ux/features/analyses/models.dart';
import 'package:dating_app_ux/features/auth/models.dart';
import 'package:dating_app_ux/features/dates/curves.dart';
import 'package:dating_app_ux/features/dates/dates_repository.dart';
import 'package:dating_app_ux/features/dates/metadata_toggle.dart';
import 'package:dating_app_ux/features/dates/models.dart';
import 'package:dating_app_ux/features/dates/results_screen.dart';
import 'package:dating_app_ux/features/dates/transcript_screen.dart';

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

Candidate _candidate(String id, String name, {double? score, int rank = 1,
    bool demo = false}) =>
    Candidate(
      candidateUserId: id,
      displayName: name,
      age: 34,
      isDemo: demo,
      traitLabels: const {'interest': ['restores old bicycles']},
      rank: rank,
      fitForward: 0.8,
      fitBackward: 0.7,
      compatibility: 0.75,
      sharedInterests: const ['bicycles'],
      reasonSummary: 'You both restore bicycles.',
      snapshotId: 's1',
      finalScore: score,
    );

// 0.30*90 + 0.30*95 + 0.25*95 + 0.15*(100-0) = 94.25
const _danCriteria = {
  'trait_alignment': 90,
  'conversational_flow': 95,
  'mutual_engagement': 95,
  'clash_severity': 0,
};
// 0.30*85 + 0.30*75 + 0.25*90 + 0.15*(100-10) = 84.0
const _bobCriteria1 = {
  'trait_alignment': 85,
  'conversational_flow': 75,
  'mutual_engagement': 90,
  'clash_severity': 10,
};
// 0.30*90 + 0.30*90 + 0.25*90 + 0.15*(100-0) = 91.5
const _bobCriteria2 = {
  'trait_alignment': 90,
  'conversational_flow': 90,
  'mutual_engagement': 90,
  'clash_severity': 0,
};

final _danDate = DateSummary(
  dateId: 'd-dan',
  candidateUserId: 'dan',
  candidateName: 'Dan',
  ordinal: 1,
  status: 'complete',
  settingName: 'Vintage Bike Exhibition',
  messageCount: 6,
  turnCount: 5,
  endedBy: 'mutual_wants_to_end',
  evaluation: const Evaluation(
    criteria: _danCriteria,
    dateScore: 94.25,
    isPartial: false,
    clickedSubjects: ['bicycle restoration', 'seventies steel'],
    clashes: [],
    perPeerSummary: {'user': 'Alice had a good evening.', 'candidate': 'So did Dan.'},
    verdictSummary: 'They got on.',
    judgeModel: 'dots-3-note-preview',
    rubricVersion: 'judge_rubric.v1',
  ),
);

final _bobDate1 = DateSummary(
  dateId: 'd-bob-1',
  candidateUserId: 'bob',
  candidateName: 'Bob',
  ordinal: 1,
  status: 'complete',
  settingName: "Bob's Garage",
  messageCount: 19,
  turnCount: 16,
  endedBy: 'cap',
  evaluation: const Evaluation(
    criteria: _bobCriteria1,
    dateScore: 84.0,
    isPartial: false,
    clickedSubjects: ['carburettors'],
    clashes: [
      Clash(
        userTrait: 'impatience',
        candidateTrait: 'need to think things through',
        moment: 'Can we just decide?',
      ),
    ],
    verdictSummary: 'Mostly fine.',
    rubricVersion: 'judge_rubric.v1',
  ),
);

final _bobDate2 = DateSummary(
  dateId: 'd-bob-2',
  candidateUserId: 'bob',
  candidateName: 'Bob',
  ordinal: 2,
  status: 'incomplete',
  settingName: 'Community Workshop',
  messageCount: 11,
  turnCount: 11,
  error: 'StructuredOutputError: gave up after 3 attempts',
  evaluation: const Evaluation(
    criteria: _bobCriteria2,
    dateScore: 91.5,
    isPartial: true,
    rubricVersion: 'judge_rubric.v1',
  ),
);

final _carolDate = DateSummary(
  dateId: 'd-carol',
  candidateUserId: 'carol',
  candidateName: 'Carol',
  ordinal: 1,
  status: 'incomplete',
  settingName: 'Vintage Bicycle Fair',
  messageCount: 6,
  turnCount: 6,
  error: 'AIError: provider returned 400',
  excludedFromScore: true,
);

// Bob's mean: (84.0×1 + 91.5×0.5) / 1.5 = 86.5
final _completeAnalysis = Analysis(
  id: 'a1',
  status: 'complete',
  poolStatus: 'full',
  createdAt: '2026-09-01T10:00:00',
  progress: const {
    'stage': 'done',
    'judged': true,
    'message': '3 dates ran and 2 people were scored.',
    'updated_at': '2026-09-01T10:30:00+00:00',
  },
  candidates: [
    _candidate('bob', 'Bob', score: 86.5, rank: 1),
    _candidate('dan', 'Dan', score: 94.25, rank: 2, demo: true),
    _candidate('carol', 'Carol', score: null, rank: 3),
  ],
);

final _transcript = Transcript(
  dateId: 'd-dan',
  analysisId: 'a1',
  status: 'complete',
  settingName: 'Vintage Bike Exhibition',
  description: 'A museum gallery of old bikes.',
  sensoryDetails: 'Chrome and old rubber.',
  userDisplayName: 'Alice',
  candidateDisplayName: 'Dan',
  schemaVersion: 'agent_response.v1',
  endedBy: 'mutual_wants_to_end',
  messages: const [
    TranscriptMessage(
      seq: 1,
      speaker: 'user_agent',
      reply: 'That chainring is original, isn’t it?',
      state: {
        'connection': 10,
        'satisfaction': 20,
        'emotional_state': 'curious',
        'state_of_mind': 'testing the waters',
        'wants_to_end': false,
      },
    ),
    TranscriptMessage(
      seq: 2,
      speaker: 'candidate_agent',
      reply: 'Seventies, mostly.',
      state: {
        'connection': 100,
        'satisfaction': 95,
        'emotional_state': 'engaged',
        'state_of_mind': 'enjoying this',
        'wants_to_end': false,
      },
    ),
    TranscriptMessage(
      seq: 3,
      speaker: 'environment',
      reply: 'Power’s out — the lights dim.',
      state: null,
    ),
    TranscriptMessage(
      seq: 4,
      speaker: 'user_agent',
      reply: 'I’ll grab the flashlight.',
      state: {
        'connection': 30,
        'satisfaction': 40,
        'emotional_state': 'amused',
        'wants_to_end': true,
      },
    ),
    TranscriptMessage(
      seq: 5,
      speaker: 'candidate_agent',
      reply: 'Let’s call it a night.',
      state: {
        'connection': 35,
        'satisfaction': 45,
        'emotional_state': 'calm',
        'wants_to_end': true,
      },
    ),
  ],
);

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

class _FakeAnalyses extends AnalysesRepository {
  _FakeAnalyses(this.analyses) : super(Dio());

  /// A queue: each `get` pops the next state, the last one repeats. This is
  /// how a test makes the poller SEE a transition.
  final List<Analysis> analyses;
  int simulateCalls = 0;
  int gets = 0;

  @override
  Future<Analysis> get(String id) async {
    gets++;
    if (analyses.length > 1) return analyses.removeAt(0);
    return analyses.first;
  }

  @override
  Future<void> simulate(String id) async {
    simulateCalls++;
  }

  @override
  Future<List<Analysis>> history() async => analyses;
}

class _FakeDates extends DatesRepository {
  _FakeDates({required this.payload, required this.transcripts}) : super(Dio());

  final DatesPayload payload;
  final Map<String, Transcript> transcripts;

  @override
  Future<DatesPayload> dates(String analysisId) async => payload;

  @override
  Future<Transcript> transcript(String dateId) async =>
      transcripts[dateId] ?? (throw StateError('no transcript $dateId'));
}

class _SignedIn extends AuthController {
  @override
  Future<User?> build() async => _me;
}

/// A router without the production guards: these tests are about the Step 13
/// screens, not the onboarding gate (which has its own test).
GoRouter _router(String initial) => GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold(body: Text('home'))),
        GoRoute(
          path: '/analyses/:id',
          builder: (_, s) => AnalysisScreen(analysisId: s.pathParameters['id']!),
          routes: [
            GoRoute(
              path: 'results',
              builder: (_, s) => ResultsScreen(analysisId: s.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: '/dates/:id',
          builder: (_, s) => TranscriptScreen(
            dateId: s.pathParameters['id']!,
            anchorSeq: int.tryParse(s.uri.queryParameters['seq'] ?? ''),
          ),
        ),
      ],
    );

Widget _app({
  required String initial,
  required _FakeAnalyses analyses,
  required _FakeDates dates,
}) {
  return ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(_SignedIn.new),
      analysesRepositoryProvider.overrideWithValue(analyses),
      datesRepositoryProvider.overrideWithValue(dates),
    ],
    child: MaterialApp.router(
      routerConfig: _router(initial),
      scaffoldMessengerKey: scaffoldMessengerKey,
      builder: (context, child) => CompletionListener(child: child!),
    ),
  );
}

/// A tall phone, so the lazily built lists render their whole content and
/// the assertions do not have to scroll-hunt.
Future<void> _pumpTall(WidgetTester tester, Widget app) async {
  tester.view.physicalSize = const Size(800, 4000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(app);
}

_FakeDates _completeDates() => _FakeDates(
      payload: DatesPayload(
        analysisId: 'a1',
        status: 'complete',
        dates: [_bobDate1, _bobDate2, _danDate, _carolDate],
      ),
      transcripts: {'d-dan': _transcript},
    );

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    // The messenger key is a global; give every test a fresh one.
    scaffoldMessengerKey.currentState?.clearSnackBars();
  });

  // -------------------------------------------------------------------------
  // The pure parts
  // -------------------------------------------------------------------------

  test('dateScoreFromCriteria is the rubric formula, verbatim', () {
    expect(dateScoreFromCriteria(_danCriteria), closeTo(94.25, 1e-9));
    expect(dateScoreFromCriteria(_bobCriteria1), closeTo(84.0, 1e-9));
    expect(dateScoreFromCriteria(_bobCriteria2), closeTo(91.5, 1e-9));
    // clash_severity is the one inverted criterion: a clash of 100 wipes
    // out its 15 points entirely.
    expect(
      dateScoreFromCriteria({..._danCriteria, 'clash_severity': 100}),
      closeTo(94.25 - 15, 1e-9),
    );
  });

  test('buildCurves: one event marker per environment row, never a zero for it',
      () {
    final c = buildCurves(_transcript);
    expect(c.eventSeqs, [3]); // AC7
    expect(c.userSatisfaction.map((p) => p.seq), [1, 4]);
    expect(c.candidateConnection.map((p) => p.value), [100, 35]);
    expect(c.maxSeq, 5);
  });

  test('endingSentence says what the server decided', () {
    expect(endingSentence(status: 'complete', endedBy: 'mutual_wants_to_end'),
        contains('natural place to stop'));
    expect(endingSentence(status: 'complete', endedBy: 'cap'),
        contains('Time was up'));
    expect(endingSentence(status: 'incomplete', endedBy: null),
        contains('stopped early'));
  });

  // -------------------------------------------------------------------------
  // Results screen (S13-U10..U13, AC4, AC5)
  // -------------------------------------------------------------------------

  testWidgets('results: ranked by final_score, unscored last and NOT zero',
      (tester) async {
    await _pumpTall(tester, _app(
      initial: '/analyses/a1/results',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();

    final dan = tester.getTopLeft(find.text('Dan, 34'));
    final bob = tester.getTopLeft(find.text('Bob, 34'));
    final carol = tester.getTopLeft(find.text('Carol, 34'));
    expect(dan.dy, lessThan(bob.dy)); // 94.25 above 86.5
    expect(bob.dy, lessThan(carol.dy)); // scored above unscored
    expect(find.text('No score'), findsOneWidget);
    expect(find.text('0.0'), findsNothing);
    // The Demo chip survives onto the results (§6).
    expect(find.text('Demo'), findsOneWidget);
  });

  testWidgets('results: tapping a score shows the four checks and the arithmetic',
      (tester) async {
    await _pumpTall(tester, _app(
      initial: '/analyses/a1/results',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('The four checks, and their weights'), findsNothing);
    await tester.tap(find.text('see checks').first); // Dan is first
    await tester.pumpAndSettle();

    expect(find.text('The four checks, and their weights'), findsOneWidget);
    for (final c in rubricWeights) {
      expect(find.text(c.label), findsOneWidget);
      expect(find.text('${(c.weight * 100).round()}%'), findsWidgets);
    }
    // AC5: the arithmetic shown matches the stored date_score.
    expect(
      find.text('0.3×90 + 0.3×95 + 0.25×95 + 0.15×(100−0) = 94.25'),
      findsOneWidget,
    );
    expect(find.textContaining('mismatch'), findsNothing);
  });

  testWidgets('results: the partial date is weighted half and the mean is shown',
      (tester) async {
    await _pumpTall(tester, _app(
      initial: '/analyses/a1/results',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();

    // AC4: incomplete labeled in the analytics, with its reason.
    expect(find.textContaining('Scored from a partial date — weighted half'),
        findsOneWidget);
    expect(find.textContaining('the AI stopped answering'), findsOneWidget);

    await tester.tap(find.text('see checks').at(1)); // Bob
    await tester.pumpAndSettle();
    expect(
      find.textContaining('(84.00×1.0 + 91.50×0.5) / 1.5 = 86.50'),
      findsOneWidget,
    );
  });

  testWidgets('results: an excluded date is listed with its reason, not smoothed over',
      (tester) async {
    await _pumpTall(tester, _app(
      initial: '/analyses/a1/results',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();
    expect(find.textContaining('too short to judge'), findsOneWidget);
    expect(find.textContaining('6 turns were spoken'), findsOneWidget);
  });

  testWidgets('results: a clash is a sentence naming both traits, with the moment',
      (tester) async {
    await _pumpTall(tester, _app(
      initial: '/analyses/a1/results',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();
    expect(
      find.textContaining(
          'Your impatience rubbed against their need to think things through'),
      findsOneWidget,
    );
    expect(find.textContaining('“Can we just decide?”'), findsOneWidget);
    // An empty clashes array is a verdict (§10), said out loud.
    expect(find.textContaining('Nothing clashed'), findsWidgets);
  });

  // -------------------------------------------------------------------------
  // Transcript viewer (S13-U6..U9, AC3, AC6)
  // -------------------------------------------------------------------------

  testWidgets('transcript: sides, event block, ending footer', (tester) async {
    await _pumpTall(tester, _app(
      initial: '/dates/d-dan',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();

    Alignment sideOf(int seq) {
      final align = find.ancestor(
        of: find.byKey(ValueKey('bubble-$seq')),
        matching: find.byType(Align),
      );
      return tester.widget<Align>(align.first).alignment as Alignment;
    }

    expect(sideOf(1), Alignment.centerRight); // your agent, right
    expect(sideOf(2), Alignment.centerLeft); // theirs, left
    expect(find.byKey(const ValueKey('event-3')), findsOneWidget);
    expect(find.text('Power’s out — the lights dim.'), findsOneWidget);
    expect(find.text('They both felt it was a natural place to stop.'),
        findsOneWidget);
    // Not running: no "still running" banner.
    expect(find.textContaining('still running'), findsNothing);
  });

  testWidgets('transcript: the metadata toggle flips both ways and persists',
      (tester) async {
    await _pumpTall(tester, _app(
      initial: '/dates/d-dan',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();

    // Default ON: badges present, including the inner-state text.
    expect(find.text('connection 100%'), findsOneWidget);
    expect(find.text('enjoying 95%'), findsOneWidget);
    expect(find.textContaining('thinking: enjoying this'), findsOneWidget);
    expect(find.text('ready to wrap up'), findsNWidgets(2));

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // OFF: a clean read, nothing left over.
    expect(find.text('connection 100%'), findsNothing);
    expect(find.textContaining('thinking:'), findsNothing);
    expect(find.text('Seventies, mostly.'), findsOneWidget);

    // Persisted per user (AC3 — survives a restart).
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('transcript_metadata.u1'), isFalse);
  });

  testWidgets('transcript: a stored OFF is honoured on a cold start',
      (tester) async {
    SharedPreferences.setMockInitialValues({'transcript_metadata.u1': false});
    await _pumpTall(tester, _app(
      initial: '/dates/d-dan',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();
    expect(find.text('connection 100%'), findsNothing);
    final container = ProviderScope.containerOf(
        tester.element(find.byType(TranscriptScreen)));
    expect(container.read(metadataToggleProvider).valueOrNull, isFalse);
  });

  testWidgets('transcript: ?seq= anchors and outlines that message',
      (tester) async {
    await _pumpTall(tester, _app(
      initial: '/dates/d-dan?seq=4',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();
    final anchored = tester.widget<Container>(
        find.byKey(const ValueKey('bubble-4')));
    final plain = tester.widget<Container>(
        find.byKey(const ValueKey('bubble-1')));
    expect((anchored.decoration as BoxDecoration).border, isNotNull);
    expect((plain.decoration as BoxDecoration).border, isNull);
  });

  testWidgets('results → curves → tap-through lands on that message (AC6)',
      (tester) async {
    await _pumpTall(tester, _app(
      initial: '/analyses/a1/results',
      analyses: _FakeAnalyses([_completeAnalysis]),
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('How it felt, over time').first); // Dan's date
    await tester.pumpAndSettle();
    expect(find.byType(SatisfactionChart), findsOneWidget);
    expect(find.text('Touch the chart to see the message at that point.'),
        findsOneWidget);

    // Drive the chart's own tap-through with the scrub state set the way a
    // touch would set it: the widget exposes the target via onOpenAt.
    final chart = tester.widget<SatisfactionChart>(find.byType(SatisfactionChart));
    chart.onOpenAt(4);
    await tester.pumpAndSettle();

    expect(find.byType(TranscriptScreen), findsOneWidget);
    final anchored = tester.widget<Container>(
        find.byKey(const ValueKey('bubble-4')));
    expect((anchored.decoration as BoxDecoration).border, isNotNull);
  });

  // -------------------------------------------------------------------------
  // The simulating phase (S13-U1..U3, U14) and the failed state (S13-U5, AC8)
  // -------------------------------------------------------------------------

  testWidgets('simulating: server stage, checklist, finished dates open early',
      (tester) async {
    final running = Analysis(
      id: 'a1',
      status: 'simulating',
      poolStatus: 'full',
      createdAt: '2026-09-01T10:00:00',
      progress: const {
        'stage': 'simulating',
        'message': 'Simulating date 2 of 3 — Bob\'s Garage…',
        'updated_at': '2026-09-01T10:05:00+00:00',
      },
      candidates: [_candidate('dan', 'Dan'), _candidate('bob', 'Bob')],
    );
    final dates = _FakeDates(
      payload: DatesPayload(
        analysisId: 'a1',
        status: 'simulating',
        dates: [
          _danDate,
          DateSummary(
            dateId: 'd-bob-1',
            candidateUserId: 'bob',
            candidateName: 'Bob',
            ordinal: 1,
            status: 'running',
            settingName: "Bob's Garage",
            messageCount: 4,
            turnCount: 4,
          ),
          const DateSummary(
            dateId: 'd-carol',
            candidateUserId: 'carol',
            candidateName: 'Carol',
            ordinal: 1,
            status: 'pending',
            settingName: 'Vintage Bicycle Fair',
          ),
        ],
      ),
      transcripts: {'d-dan': _transcript},
    );
    await _pumpTall(tester, _app(
      initial: '/analyses/a1',
      analyses: _FakeAnalyses([running]),
      dates: dates,
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Simulating date 2 of 3 — Bob\'s Garage…'), findsOneWidget);
    expect(find.text('You can leave — this keeps running.'), findsOneWidget);
    expect(find.text('Waiting its turn'), findsOneWidget);
    expect(find.textContaining('Running — 4 messages so far'), findsOneWidget);
    expect(find.text('They both felt it was a natural place to stop.'),
        findsOneWidget);

    // S13-U3: the finished date opens while the others run.
    await tester.tap(find.text('Vintage Bike Exhibition'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(TranscriptScreen), findsOneWidget);
    // S13-U14: honestly framed.
    expect(find.text('Other dates are still running'), findsOneWidget);
    expect(find.text('Seventies, mostly.'), findsOneWidget);
  });

  testWidgets('failed after matching: names the stage; retry RESUMES via /simulate',
      (tester) async {
    final failed = Analysis(
      id: 'a1',
      status: 'failed',
      poolStatus: 'full',
      error: 'AIError: openrouter error 400',
      createdAt: '2026-09-01T10:00:00',
      progress: const {
        'stage': 'simulating',
        'message': 'Simulating date 1 of 2 — Bob\'s Garage…',
      },
      candidates: [_candidate('bob', 'Bob')],
    );
    final analyses = _FakeAnalyses([failed]);
    await _pumpTall(tester, _app(
      initial: '/analyses/a1',
      analyses: analyses,
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('This analysis stopped during the dates'), findsOneWidget);
    expect(find.textContaining("Last thing it was doing: Simulating date 1 of 2"),
        findsOneWidget);
    await tester.tap(find.text('Pick up where it stopped'));
    // Not pumpAndSettle: the kicked poller keeps a timer alive on purpose.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(analyses.simulateCalls, 1); // the retry calls /simulate, not /analyses
    // The poller was kicked: it polls THROUGH the still-`failed` row instead
    // of stopping on it, so the flip to `simulating` will be seen.
    final before = analyses.gets;
    await tester.pump(const Duration(seconds: 4));
    expect(analyses.gets, greaterThan(before));
    // Hand the button back rather than spin forever over an accepted request.
    expect(find.text('Pick up where it stopped'), findsOneWidget);
  });

  testWidgets('failed in matching: nothing to resume, offers a new analysis',
      (tester) async {
    final failed = Analysis(
      id: 'a1',
      status: 'failed',
      error: 'embedding quota',
      createdAt: '2026-09-01T10:00:00',
    );
    final analyses = _FakeAnalyses([failed]);
    await _pumpTall(tester, _app(
      initial: '/analyses/a1',
      analyses: analyses,
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();
    expect(find.text('This analysis stopped while working out who fits'),
        findsOneWidget);
    expect(find.text('Start a new analysis'), findsOneWidget);
    expect(find.text('Pick up where it stopped'), findsNothing);
  });

  // -------------------------------------------------------------------------
  // S13-U4: the live finish is announced app-wide
  // -------------------------------------------------------------------------

  testWidgets('poller announces simulating → complete with a banner',
      (tester) async {
    final running = _completeAnalysis.copyWith(
      status: 'simulating',
      progress: const {'stage': 'simulating', 'message': 'Simulating…'},
    );
    final analyses = _FakeAnalyses([running, _completeAnalysis]);
    await _pumpTall(tester, _app(
      initial: '/', // the user has LEFT the progress screen
      analyses: analyses,
      dates: _completeDates(),
    ));
    await tester.pumpAndSettle();

    // Something in the app is watching the analysis (as the dashboard's
    // running card would): start the ONE poller.
    final container =
        ProviderScope.containerOf(tester.element(find.text('home')));
    container.listen(analysisPollerProvider('a1'), (_, _) {});
    await tester.pump();
    expect(find.textContaining('Your dates have finished'), findsNothing);

    // Next tick (3s) sees `complete`.
    await tester.pump(const Duration(seconds: 4));
    await tester.pump();
    expect(find.textContaining('Your dates have finished'), findsOneWidget);
    expect(find.text('See results'), findsOneWidget);
    expect(container.read(finishedAnalysisProvider)?.id, 'a1');
    expect(analyses.gets, 2);
    // Terminal: no third poll.
    await tester.pump(const Duration(seconds: 12));
    expect(analyses.gets, 2);
  });
}
