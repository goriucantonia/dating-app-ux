import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/auth/auth_controller.dart';
import 'models.dart';

/// What `POST /profile/extract` said. `queued` means another run for this
/// person was already in flight (typically an earlier attempt that outlived a
/// client timeout) and this request will follow it — the caller must wait for
/// that run, not compile from whatever traits exist right now.
class ExtractOutcome {
  const ExtractOutcome({required this.status, required this.changed});

  final String status; // 'done' | 'queued'
  final bool changed;

  bool get queued => status == 'queued';
}

/// `GET /profile/extract/status`: whether a run is in flight, and how the
/// most recent background run ended (null until one has).
class ExtractStatus {
  const ExtractStatus({required this.running, this.lastStatus, this.lastError, this.changed});

  final bool running;
  final String? lastStatus; // 'done' | 'failed' | 'queued' | null
  final String? lastError;
  final bool? changed;

  bool get failed => lastStatus == 'failed';
  bool get done => lastStatus == 'done';
}

class PersonaRepository {
  PersonaRepository(this._dio);

  final Dio _dio;

  /// Start-then-poll (S7-B7): this returns as soon as the job is accepted,
  /// not when the persona is built. `already_compiling` is not a failure.
  Future<String> startCompile() async {
    final r = await _wrap(
        () => _dio.post<Map<String, dynamic>>('/persona/compile'));
    return r.data!['status'] as String;
  }

  Future<PersonaState> current() async {
    final r =
        await _wrap(() => _dio.get<Map<String, dynamic>>('/persona/current'));
    return PersonaState.fromJson(r.data!);
  }

  /// Runs the extraction INLINE on the server (22–127 s measured), hence the
  /// long timeout; the body is read now instead of discarded (audit
  /// 2026-09-02) because `queued` changes what the caller has to do next.
  ///
  /// With `wait: false` the server answers `started` at once and runs the
  /// extraction in the background; poll [extractStatus] until `running`
  /// is false. This is the form the app uses — the long timeout is only
  /// the fallback for the synchronous form the probes rely on.
  Future<ExtractOutcome> extract({bool wait = false}) async {
    final r = await _wrap(() => _dio.post<Map<String, dynamic>>(
        '/profile/extract',
        queryParameters: {'wait': wait},
        options: modelCallOptions));
    final d = r.data ?? const <String, dynamic>{};
    return ExtractOutcome(
      status: d['status'] as String? ?? 'done',
      changed: d['changed'] as bool? ?? true,
    );
  }

  /// `GET /profile/extract/status` — the server has exposed this since Step 7
  /// and nothing read it.
  Future<ExtractStatus> extractStatus() async {
    final r = await _wrap(
        () => _dio.get<Map<String, dynamic>>('/profile/extract/status'));
    final d = r.data ?? const <String, dynamic>{};
    final last = d['last'];
    return ExtractStatus(
      running: d['running'] as bool? ?? false,
      lastStatus: last is Map ? last['status'] as String? : null,
      lastError: last is Map ? last['error'] as String? : null,
      changed: last is Map ? last['changed'] as bool? : null,
    );
  }

  Future<bool> extractRunning() async => (await extractStatus()).running;

  Future<T> _wrap<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }
}

final personaRepositoryProvider = Provider<PersonaRepository>(
    (ref) => PersonaRepository(ref.watch(apiClientProvider)));

/// Rebuilds on login/logout like `questionsProvider`, so a second account in
/// the same session never sees the first one's persona. (The comment used to
/// say this and the code did not — audit 2026-09-02.)
final personaProvider = FutureProvider<PersonaState>((ref) async {
  // Signed out (or not yet known): no request. A tokenless fetch here was
  // a 401 nobody wanted, and a second fetch the moment auth resolved.
  // Loading until a person is signed in; rebuilt when that changes.
  if (ref.watch(currentUserIdProvider) == null) return Completer<PersonaState>().future;
  return ref.watch(personaRepositoryProvider).current();
});
