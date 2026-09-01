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
const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8000',
);

/// The server's one error envelope, thrown as one exception type. `message`
/// is layman-readable by contract and may be shown verbatim
/// (communication_protocol.md §5).
class ApiException implements Exception {
  const ApiException({required this.code, required this.message, this.status});

  final String code;
  final String message;
  final int? status;

  static ApiException from(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['error'] is Map) {
      final err = data['error'] as Map;
      return ApiException(
        code: err['code'] as String? ?? 'error',
        message: err['message'] as String? ?? 'Something went wrong.',
        status: e.response?.statusCode,
      );
    }
    return ApiException(
      code: 'network',
      message: "Couldn't reach the server — is it running?",
      status: e.response?.statusCode,
    );
  }

  @override
  String toString() => 'ApiException($code: $message)';
}

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
        }
        handler.next(options);
      },
      onError: (e, handler) {
        // A 401 anywhere (outside login itself) means the session is dead
        // (communication_protocol.md §3) — one place decides that.
        if (e.response?.statusCode == 401 &&
            !e.requestOptions.path.startsWith('/auth/')) {
          ref.read(authControllerProvider.notifier).sessionExpired();
        }
        handler.next(e);
      },
    ),
  );
  return dio;
});
