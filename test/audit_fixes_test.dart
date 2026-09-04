/// Pins for the 2026-09-02 audit fixes that can be checked without a server:
/// the timeout wording, and the one poller stopping on a status the next tick
/// cannot change.
library;

import 'package:dio/dio.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dating_app_ux/core/api/api_client.dart';
import 'package:dating_app_ux/core/polling/poller.dart';
import 'package:dating_app_ux/features/analyses/analyses_repository.dart';
import 'package:dating_app_ux/features/analyses/models.dart';

DioException _dio(DioExceptionType type, {Response<dynamic>? response}) =>
    DioException(
      requestOptions: RequestOptions(path: '/x'),
      type: type,
      response: response,
    );

class _Repo extends AnalysesRepository {
  _Repo(this.script) : super(Dio());

  /// Each `get` takes the next item: an [Analysis] is returned, an
  /// [ApiException] is thrown. The last item repeats.
  final List<Object> script;
  int gets = 0;

  @override
  Future<Analysis> get(String id) async {
    gets++;
    final next = script.length > 1 ? script.removeAt(0) : script.first;
    if (next is ApiException) throw next;
    return next as Analysis;
  }
}

Analysis _analysis(String status) => Analysis(
      id: 'a1',
      status: status,
      poolStatus: 'full',
      createdAt: '2026-09-02T10:00:00',
      candidates: const [],
    );

void main() {
  group('ApiException.from', () {
    test('a receive timeout is named as such, not as the server being down',
        () {
      final e = ApiException.from(_dio(DioExceptionType.receiveTimeout));
      expect(e.code, 'timeout');
      expect(e.mayHaveLanded, isTrue);
      expect(e.message, contains('still working'));
      expect(e.message, isNot(contains('is it running')));
    });

    test('a connection failure is still the network sentence', () {
      final e = ApiException.from(_dio(DioExceptionType.connectionError));
      expect(e.code, 'network');
      expect(e.mayHaveLanded, isFalse);
    });

    test('an envelope wins over the transport type', () {
      final e = ApiException.from(_dio(
        DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/x'),
          statusCode: 409,
          data: {
            'error': {'code': 'chat_busy', 'message': 'A reply is on its way.'}
          },
        ),
      ));
      expect(e.code, 'chat_busy');
      expect(e.status, 409);
    });
  });

  group('AnalysisPoller', () {
    test('keeps polling through a transient failure', () {
      fakeAsync((async) {
        final repo = _Repo([
          const ApiException(code: 'network', message: 'down', status: null),
          _analysis('simulating'),
          _analysis('complete'),
        ]);
        final poller = AnalysisPoller(repo, 'a1');
        async.flushMicrotasks();
        expect(repo.gets, 1);
        async.elapse(const Duration(seconds: 3));
        async.flushMicrotasks();
        expect(repo.gets, 2); // the loop survived the error
        async.elapse(const Duration(seconds: 3));
        async.flushMicrotasks();
        expect(repo.gets, 3);
        expect(poller.state.valueOrNull?.status, 'complete');
        async.elapse(const Duration(seconds: 30));
        expect(repo.gets, 3); // terminal: stopped
        poller.dispose();
      });
    });

    test('stops on a 404 — the next tick cannot make the analysis exist', () {
      fakeAsync((async) {
        final repo = _Repo([
          const ApiException(
              code: 'not_found', message: 'gone', status: 404),
        ]);
        final poller = AnalysisPoller(repo, 'a1');
        async.flushMicrotasks();
        expect(repo.gets, 1);
        expect(poller.state.hasError, isTrue);
        async.elapse(const Duration(minutes: 1));
        expect(repo.gets, 1, reason: 'a 404 used to poll for ever');
        poller.dispose();
      });
    });

    test('stops on a 401 — the session is dead, not slow', () {
      fakeAsync((async) {
        final repo = _Repo([
          _analysis('simulating'),
          const ApiException(
              code: 'unauthenticated', message: 'sign in', status: 401),
        ]);
        final poller = AnalysisPoller(repo, 'a1');
        async.flushMicrotasks();
        async.elapse(const Duration(seconds: 3));
        async.flushMicrotasks();
        expect(repo.gets, 2);
        // Data is kept (the screen still has something to show) but the
        // loop is over.
        expect(poller.state.valueOrNull?.status, 'simulating');
        async.elapse(const Duration(minutes: 1));
        expect(repo.gets, 2);
        poller.dispose();
      });
    });
  });
}
