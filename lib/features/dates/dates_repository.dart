import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/polling/poller.dart';
import 'models.dart';

/// The two lazy reads of the simulation (S13-U15): the date list and one
/// transcript. Neither is polled — the ONE poller watches the analysis row,
/// and these refetch only when it says something moved.
class DatesRepository {
  DatesRepository(this._dio);

  final Dio _dio;

  Future<DatesPayload> dates(String analysisId) async {
    final r = await _wrap(
        () => _dio.get<Map<String, dynamic>>('/analyses/$analysisId/dates'));
    return DatesPayload.fromJson(r.data!);
  }

  Future<Transcript> transcript(String dateId) async {
    final r = await _wrap(
        () => _dio.get<Map<String, dynamic>>('/dates/$dateId/transcript'));
    return Transcript.fromJson(r.data!);
  }

  Future<T> _wrap<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }
}

final datesRepositoryProvider = Provider<DatesRepository>(
    (ref) => DatesRepository(ref.watch(apiClientProvider)));

/// The date list for one analysis.
///
/// It re-reads exactly when the shared poller reports that the server's
/// `progress` moved (a date started, finished, or the judge ran) — so the
/// checklist grid during `simulating` is live without a second polling loop
/// (§16). On a terminal status the poller stops ticking, this key stops
/// changing, and the results are fetched ONCE and kept for the session
/// (S13-U15).
final datesProvider =
    FutureProvider.family<DatesPayload, String>((ref, analysisId) async {
  ref.watch(analysisPollerProvider(analysisId).select((s) {
    final a = s.valueOrNull;
    return '${a?.status}|${a?.progress?['updated_at']}';
  }));
  return ref.watch(datesRepositoryProvider).dates(analysisId);
});

/// One transcript, fetched lazily on first open and cached in memory for the
/// session (S13-U15). A `running` date's transcript grows; the viewer offers
/// a refresh rather than polling, because a transcript is not the object the
/// app polls.
final transcriptProvider =
    FutureProvider.family<Transcript, String>((ref, dateId) async {
  return ref.watch(datesRepositoryProvider).transcript(dateId);
});
