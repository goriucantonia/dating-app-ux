import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import 'models.dart';

/// Hand-written repository over the auth + /me endpoints (S4-U1;
/// ux_architecture.md §1.3 — no OpenAPI codegen this phase, by named trade).
/// Every DioException is rethrown as the one ApiException type.
class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  Future<({String token, User user})> register(RegisterData data) async {
    final r = await _wrap(
        () => _dio.post<Map<String, dynamic>>('/auth/register', data: data.toJson()));
    return (
      token: r.data!['token'] as String,
      user: User.fromJson(r.data!['user'] as Map<String, dynamic>),
    );
  }

  Future<({String token, User user})> login(String email, String password) async {
    final r = await _wrap(() => _dio.post<Map<String, dynamic>>(
        '/auth/login', data: {'email': email, 'password': password}));
    return (
      token: r.data!['token'] as String,
      user: User.fromJson(r.data!['user'] as Map<String, dynamic>),
    );
  }

  Future<User> me() async {
    final r = await _wrap(() => _dio.get<Map<String, dynamic>>('/me'));
    return User.fromJson(r.data!);
  }

  Future<User> patchMe(Map<String, dynamic> changes) async {
    final r = await _wrap(() => _dio.patch<Map<String, dynamic>>('/me', data: changes));
    return User.fromJson(r.data!);
  }

  /// S15-U1. Returns the server's receipt: the per-table counts it logged
  /// BEFORE the cascade ran. The session is dead after this.
  Future<DeletionReceipt> deleteMe() async {
    final r = await _wrap(() => _dio.delete<Map<String, dynamic>>('/me'));
    final deleted = (r.data!['deleted'] as Map).map(
        (k, v) => MapEntry(k as String, (v as num).toInt()));
    return DeletionReceipt(
      deleted: deleted,
      rowsRemoved: (r.data!['rows_removed'] as num).toInt(),
    );
  }

  Future<T> _wrap<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }
}

/// The deletion receipt (S15-B2): what went, per table, counted before it went.
class DeletionReceipt {
  const DeletionReceipt({required this.deleted, required this.rowsRemoved});

  final Map<String, int> deleted;
  final int rowsRemoved;
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.watch(apiClientProvider)));
