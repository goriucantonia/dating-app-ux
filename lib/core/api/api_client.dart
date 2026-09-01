import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

/// One dio instance for the whole app. The JWT bearer interceptor and the
/// 401→login redirect are added HERE in Step 4 — one interceptor, one place
/// (§16). Repositories receive this client; nothing constructs its own.
final apiClientProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
});
