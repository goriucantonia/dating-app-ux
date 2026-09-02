/// Step 17 widget tests — turning a candidate down before the dates run,
/// against a MOCKED repository. No server, no model calls.
///
/// What these pin is the part a user can be hurt by: that the swap is
/// confirmed before it happens, that a refusal is SHOWN rather than swallowed,
/// and that the action is absent in every state where the server would refuse
/// it anyway.
library;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dating_app_ux/core/api/api_client.dart';
import 'package:dating_app_ux/core/auth/auth_controller.dart';
import 'package:dating_app_ux/features/analyses/analyses_repository.dart';
import 'package:dating_app_ux/features/analyses/analysis_screen.dart';
import 'package:dating_app_ux/features/analyses/models.dart';
import 'package:dating_app_ux/features/auth/models.dart';
import 'package:dating_app_ux/features/dates/dates_repository.dart';
import 'package:dating_app_ux/features/dates/models.dart';

const _me = User(
  id: 'u1',
  email: 'me@example.com',
  displayName: 'Alice',
  birthDate: '1996-04-18',
  age: 30,
  gender: 'woman',
  interestedIn: ['man', 'woman'],
  agePrefMin: 24,
  agePrefMax: 45,
  optIn: true,
  isDemo: false,
);

Candidate _c(String id, String name, {required int rank, double fit = 0.66}) =>
    Candidate(
      candidateUserId: id,
      displayName: name,
      age: 34,
      isDemo: true,
      traitLabels: const {},
      rank: rank,
      fitForward: fit,
      fitBackward: fit,
      compatibility: fit,
      sharedInterests: const [],
      reasonSummary: 'About equally matched.',
      snapshotId: 's-$id',
    );

Analysis _analysis(List<Candidate> candidates, {String status = 'matched'}) =>
    Analysis(
      id: 'a1',
      status: status,
      poolStatus: candidates.length >= 3 ? 'full' : 'partial',
      createdAt: '2026-09-02T06:48:00',
      candidates: candidates,
    );

final _three = [
  _c('theo', 'Theo', rank: 1, fit: 0.660),
  _c('victor', 'Victor', rank: 2, fit: 0.658),
  _c('dan', 'Dan', rank: 3, fit: 0.655),
];

/// The line-up the server answers with after Dan is turned down: Radu takes
/// the seat and the ranks close up behind him.
final _afterSwap = [
  _c('theo', 'Theo', rank: 1, fit: 0.660),
  _c('victor', 'Victor', rank: 2, fit: 0.658),
  _c('radu', 'Radu', rank: 3, fit: 0.649),
];

class _FakeAnalyses extends AnalysesRepository {
  _FakeAnalyses(this.analysis, {this.replacement, this.refusal}) : super(Dio());

  Analysis analysis;
  final List<Candidate>? replacement;
  final String? refusal;
  final List<String> rejected = [];

  @override
  Future<Analysis> get(String id) async => analysis;

  @override
  Future<Analysis> rejectCandidate(String analysisId, String candidateUserId) async {
    rejected.add(candidateUserId);
    if (refusal != null) {
      throw ApiException(code: 'cannot_reject_now', message: refusal!);
    }
    analysis = _analysis(replacement ?? const []);
    return analysis;
  }
}

class _FakeDates extends DatesRepository {
  _FakeDates() : super(Dio());

  @override
  Future<DatesPayload> dates(String analysisId) async =>
      const DatesPayload(analysisId: 'a1', status: 'matched', dates: []);
}

class _SignedIn extends AuthController {
  @override
  Future<User?> build() async => _me;
}

GoRouter _router() => GoRouter(
      initialLocation: '/analyses/a1',
      routes: [
        GoRoute(
          path: '/analyses/:id',
          builder: (_, s) => AnalysisScreen(analysisId: s.pathParameters['id']!),
        ),
      ],
    );

Future<void> _pump(WidgetTester tester, _FakeAnalyses analyses) async {
  tester.view.physicalSize = const Size(800, 2600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(_SignedIn.new),
      analysesRepositoryProvider.overrideWithValue(analyses),
      datesRepositoryProvider.overrideWithValue(_FakeDates()),
    ],
    child: MaterialApp.router(routerConfig: _router()),
  ));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the swap is offered on a matched analysis, once per candidate',
      (tester) async {
    await _pump(tester, _FakeAnalyses(_analysis(_three)));
    expect(find.text('Not this one'), findsNWidgets(3));
  });

  testWidgets('nothing is swapped until the confirmation is accepted',
      (tester) async {
    final analyses = _FakeAnalyses(_analysis(_three), replacement: _afterSwap);
    await _pump(tester, analyses);

    await tester.tap(find.text('Not this one').last); // Dan, rank 3
    await tester.pumpAndSettle();
    // The two things the user cannot see for themselves.
    expect(find.text('Not Dan?'), findsOneWidget);
    expect(find.textContaining("can't put them back"), findsOneWidget);
    expect(find.textContaining('next person who fits takes their place'),
        findsOneWidget);

    await tester.tap(find.text('Keep Dan'));
    await tester.pumpAndSettle();
    expect(analyses.rejected, isEmpty);
    expect(find.text('Dan, 34'), findsOneWidget);
  });

  testWidgets('confirming swaps the person out and names who took the seat',
      (tester) async {
    final analyses = _FakeAnalyses(_analysis(_three), replacement: _afterSwap);
    await _pump(tester, analyses);

    await tester.tap(find.text('Not this one').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Swap them out'));
    await tester.pumpAndSettle();

    expect(analyses.rejected, ['dan']);
    expect(find.text('Dan, 34'), findsNothing);
    expect(find.text('Radu, 34'), findsOneWidget);
    // Said out loud, not left to be noticed.
    expect(find.textContaining('Radu takes their place'), findsOneWidget);
  });

  testWidgets('when nobody is left to take the seat, the result says so',
      (tester) async {
    final analyses = _FakeAnalyses(
      _analysis(_three),
      replacement: [
        _c('theo', 'Theo', rank: 1, fit: 0.660),
        _c('victor', 'Victor', rank: 2, fit: 0.658),
      ],
    );
    await _pump(tester, analyses);

    await tester.tap(find.text('Not this one').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Swap them out'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Nobody else fits right now'), findsOneWidget);
    expect(find.text('Not this one'), findsNWidgets(2));
  });

  testWidgets('a server refusal is shown in the server’s own words',
      (tester) async {
    final analyses = _FakeAnalyses(
      _analysis(_three),
      refusal: "They're the only person left who fits, and there's nobody "
          'waiting to take their place. Start a new analysis instead.',
    );
    await _pump(tester, analyses);

    await tester.tap(find.text('Not this one').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Swap them out'));
    await tester.pumpAndSettle();

    expect(find.textContaining('only person left who fits'), findsOneWidget);
    // Refused means unchanged: the card is still there.
    expect(find.text('Theo, 34'), findsOneWidget);
  });

  testWidgets('the swap is absent once the dates have run', (tester) async {
    await _pump(tester, _FakeAnalyses(_analysis(_three, status: 'complete')));
    expect(find.text('Not this one'), findsNothing);
  });
}
