import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// A candidate as the wire delivers it.
///
/// There is deliberately **no `description` field** and no raw answers: the
/// server sends trait LABELS only (`communication_protocol.md` §6). A field
/// here would be an invitation to start sending them, and descriptions are
/// written about someone by an AI reading their intimate answers — showing
/// those to a stranger is a different product.
@freezed
abstract class Candidate with _$Candidate {
  const factory Candidate({
    @JsonKey(name: 'candidate_user_id') required String candidateUserId,
    @JsonKey(name: 'display_name') required String displayName,
    required int age,
    @JsonKey(name: 'is_demo') required bool isDemo,
    @JsonKey(name: 'trait_labels') required Map<String, List<String>> traitLabels,
    required int rank,
    @JsonKey(name: 'fit_forward') required double fitForward,
    @JsonKey(name: 'fit_backward') required double fitBackward,
    required double compatibility,
    @JsonKey(name: 'shared_interests') required List<String> sharedInterests,
    @JsonKey(name: 'reason_summary') required String reasonSummary,
    @JsonKey(name: 'snapshot_id') required String snapshotId,
  }) = _Candidate;

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);
}

@freezed
abstract class Analysis with _$Analysis {
  const factory Analysis({
    required String id,
    // matching | matched | no_candidates | simulating | complete | failed
    required String status,
    @JsonKey(name: 'pool_status') String? poolStatus,
    String? error,
    @JsonKey(name: 'created_at') required String createdAt,
    @Default(<Candidate>[]) List<Candidate> candidates,
    String? message,
    // The simulation pipeline's real stage, in the sentence the server wrote
    // (S11-B10). Deliberately untyped: the stage NAMES are the server's to
    // add to, and a client that models them as an enum starts crashing the
    // day the pipeline grows a stage. The UI reads `message` and treats
    // anything it does not recognise as "still working".
    Map<String, dynamic>? progress,
  }) = _Analysis;

  factory Analysis.fromJson(Map<String, dynamic> json) =>
      _$AnalysisFromJson(json);
}
