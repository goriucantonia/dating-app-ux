import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_controller.dart';
import '../auth/token_store.dart';

/// The app's SINGLE piece of environment configuration
/// (communication_protocol.md §2): where the API lives. Local-only phase —
/// revisited with the hosting decision, not before it.
///
/// Override at run/build time with
/// `--dart-define=API_BASE_URL=http://host:port` (no code change).
/// On the Android emulator the host machine is `10.0.2.2`, not `localhost`.
const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8000',
);

/// Per-request options for endpoints that run a MODEL CALL inline before
/// answering: trait extraction, chat and calibration replies, dispute
/// follow-ups, candidate rejection. Measured extraction latency on the free
/// tier is 22–127 s; the default 30 s receive timeout below fired first, the
/// user was told the server was down, and a retry double-spent the calls
/// (audit 2026-09-02). Three minutes covers the server's own retry ladder.
final modelCallOptions = Options(receiveTimeout: const Duration(minutes: 3));

/// The server's one error envelope, thrown as one exception type. `message`
/// is layman-readable by contract and may be shown verbatim
/// (communication_protocol.md §5).
class ApiException implements Exception {
  const ApiException({
    required this.code,
    required this.message,
    this.status,
    this.fields = const [],
  });

  final String code;
  final String message;
  final int? status;

  /// Per-field messages from a 422, `(field, message)`. The server built
  /// these from the start and the client dropped them (audit 2026-09-02).
  final List<({String field, String message})> fields;

  /// True for a failure where the request may well have SUCCEEDED server-side
  /// (a timeout, a dropped connection after sending): callers that would
  /// retry should re-read first rather than re-send.
  bool get mayHaveLanded => code == 'timeout';

  static ApiException from(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['error'] is Map) {
      final err = data['error'] as Map;
      final fields = <({String field, String message})>[
        if (err['fields'] is List)
          for (final f in err['fields'] as List)
            if (f is Map)
              (
                field: (f['field'] as String? ?? '').replaceAll('_', ' '),
                message: f['message'] as String? ?? '',
              ),
      ];
      var message = err['message'] as String? ?? 'Something went wrong.';
      final code = err['code'] as String? ?? 'error';
      if (code == 'validation_error' && fields.isNotEmpty) {
        // The field sentences ARE the message a person can act on; the
        // generic one only says that something, somewhere, is off.
        message = fields
            .map((f) => f.field.isEmpty ? f.message : '${f.field}: ${f.message}')
            .join('\n');
      }
      return ApiException(
        code: code,
        message: message,
        status: e.response?.statusCode,
        fields: fields,
      );
    }
    // No envelope. Three different things used to share one sentence — a
    // server that is down, a request that outlived its timeout while the
    // server carried on, and a 500 without CORS headers. Name the one we can
    // tell apart.
    switch (e.type) {
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException(
          code: 'timeout',
          message: "The server is taking longer than usual — it's still "
              'working on it. Give it a moment and check again.',
          status: e.response?.statusCode,
        );
      default:
        return ApiException(
          code: 'network',
          message: "Couldn't reach the server — is it running?",
          status: e.response?.statusCode,
        );
    }
  }

  @override
  String toString() => 'ApiException($code: $message)';
}

const _sentTokenKey = 'sent_token';

/// One dio instance for the whole app, carrying the ONE auth interceptor
/// (§16): it attaches the bearer token and routes every 401 to the login
/// state. No other code touches headers or handles 401s.
final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = ref.read(tokenStoreProvider).token;
        if (token != null && !options.path.startsWith('/auth/')) {
          options.headers['Authorization'] = 'Bearer $token';
          options.extra[_sentTokenKey] = token;
        }
        handler.next(options);
      },
      onError: (e, handler) {
        // A 401 anywhere (outside login itself) means the session is dead
        // (communication_protocol.md §3) — one place decides that.
        //
        // But only when the request actually CARRIED the current token. A
        // request sent before the token loaded, or with a token that has
        // since been replaced by a fresh sign-in, says nothing about the
        // stored session — and acting on it used to delete a valid session
        // on every cold start (audit 2026-09-02).
        final sent = e.requestOptions.extra[_sentTokenKey];
        final current = ref.read(tokenStoreProvider).token;
        if (e.response?.statusCode == 401 &&
            !e.requestOptions.path.startsWith('/auth/') &&
            sent != null &&
            sent == current) {
          ref.read(authControllerProvider.notifier).sessionExpired();
        }
        handler.next(e);
      },
    ),
  );
  return dio;
});
