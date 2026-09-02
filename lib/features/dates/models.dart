import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// What the judge found, BOTH halves (S12, S13-U10): the model's raw
/// `criteria` and the code's `date_score`. The results screen recomputes the
/// score from the criteria in front of the user — that is the whole point of
/// shipping both, and [rubricWeights] below is the arithmetic it uses.
@freezed
abstract class Evaluation with _$Evaluation {
  const factory Evaluation({
    required Map<String, dynamic> criteria,
    @JsonKey(name: 'date_score') required double dateScore,
    @JsonKey(name: 'is_partial') required bool isPartial,
    // How much the transcript supported the judge's reading, 0-100, said by
    // the judge (`judge_rubric.v2`). NULLABLE and it must stay so: evaluations
    // written under v1 have none, and a 0 in its place would read as "the
    // judge was certain of nothing" about a reading it was never asked to
    // qualify. Rendered only when present.
    int? confidence,
    @JsonKey(name: 'evidence_note') @Default('') String evidenceNote,
    @JsonKey(name: 'clicked_subjects') @Default(<String>[]) List<String> clickedSubjects,
    @Default(<Clash>[]) List<Clash> clashes,
    @JsonKey(name: 'per_peer_summary') @Default(<String, dynamic>{}) Map<String, dynamic> perPeerSummary,
    @JsonKey(name: 'verdict_summary') @Default('') String verdictSummary,
    @JsonKey(name: 'judge_provider') @Default('') String judgeProvider,
    @JsonKey(name: 'judge_model') @Default('') String judgeModel,
    @JsonKey(name: 'rubric_version') @Default('') String rubricVersion,
  }) = _Evaluation;

  factory Evaluation.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFromJson(json);
}

/// A clash is only reported with a citable moment (§10) — the sentence the UI
/// builds from it names both traits AND quotes the moment (S13-U11).
@freezed
abstract class Clash with _$Clash {
  const factory Clash({
    @JsonKey(name: 'user_trait') @Default('') String userTrait,
    @JsonKey(name: 'candidate_trait') @Default('') String candidateTrait,
    @Default('') String moment,
  }) = _Clash;

  factory Clash.fromJson(Map<String, dynamic> json) => _$ClashFromJson(json);
}

/// One date as `GET /analyses/{id}/dates` lists it.
///
/// `excludedFromScore` and `endedBy` come from the SERVER and are never
/// derived here: a client with its own idea of what "mutual" means, or of when
/// a date counts, is a client that can disagree with the score it is showing.
///
/// Since 2026-09-02 `excludedFromScore` means only "nobody spoke on this
/// date". The ten-turn "too short to score" rule is gone — every date that has
/// a transcript is judged, and how thin it was is reported as the judge's
/// [Evaluation.confidence] rather than used to throw the date away.
@freezed
abstract class DateSummary with _$DateSummary {
  const factory DateSummary({
    @JsonKey(name: 'date_id') required String dateId,
    @JsonKey(name: 'candidate_user_id') required String candidateUserId,
    @JsonKey(name: 'candidate_name') required String candidateName,
    required int ordinal,
    // pending | running | complete | incomplete | failed
    required String status,
    @JsonKey(name: 'setting_name') @Default('') String settingName,
    @Default('') String description,
    @JsonKey(name: 'sensory_details') @Default('') String sensoryDetails,
    // The archetype key this analysis drew — the SAME on every date of an
    // analysis, which is the whole point. Empty on dates from before
    // 2026-09-02, which each had their own interest-anchored setting and no
    // archetype. It replaced `anchored_in_interest`, which described a
    // property the fixture deliberately no longer has.
    @Default('') String archetype,
    @JsonKey(name: 'message_count') @Default(0) int messageCount,
    @JsonKey(name: 'turn_count') @Default(0) int turnCount,
    String? error,
    @JsonKey(name: 'ended_by') String? endedBy,
    Evaluation? evaluation,
    @JsonKey(name: 'excluded_from_score') @Default(false) bool excludedFromScore,
  }) = _DateSummary;

  factory DateSummary.fromJson(Map<String, dynamic> json) =>
      _$DateSummaryFromJson(json);
}

/// The one evening every candidate in an analysis was run against.
///
/// It is shipped as its own object rather than inferred by comparing three
/// `settingName` strings, because "they all went to the same place, so these
/// scores compare" is the claim the results screen rests on — and a claim the
/// client works out by string comparison is a claim it can get wrong.
@freezed
abstract class Fixture with _$Fixture {
  const factory Fixture({
    @JsonKey(name: 'setting_name') @Default('') String settingName,
    @Default('') String archetype,
    @JsonKey(name: 'dates_per_candidate') @Default(1) int datesPerCandidate,
  }) = _Fixture;

  factory Fixture.fromJson(Map<String, dynamic> json) => _$FixtureFromJson(json);
}

@freezed
abstract class DatesPayload with _$DatesPayload {
  const factory DatesPayload({
    @JsonKey(name: 'analysis_id') required String analysisId,
    required String status,
    Map<String, dynamic>? progress,
    // Null for an analysis that ran before the shared fixture existed. Those
    // genuinely had none — each date had its own setting — and the screen has
    // to be able to say nothing rather than claim a fixture that never was.
    Fixture? fixture,
    @Default(<DateSummary>[]) List<DateSummary> dates,
  }) = _DatesPayload;

  factory DatesPayload.fromJson(Map<String, dynamic> json) =>
      _$DatesPayloadFromJson(json);
}

/// One row of a transcript. `state` is null on `environment` rows — an event
/// has no inner life — and the viewer must render that absence as absence,
/// not as an agent who felt nothing (S13-U13).
@freezed
abstract class TranscriptMessage with _$TranscriptMessage {
  const factory TranscriptMessage({
    required int seq,
    // user_agent | candidate_agent | environment
    required String speaker,
    required String reply,
    Map<String, dynamic>? state,
    String? provider,
    @JsonKey(name: 'model_id') String? modelId,
  }) = _TranscriptMessage;

  factory TranscriptMessage.fromJson(Map<String, dynamic> json) =>
      _$TranscriptMessageFromJson(json);
}

@freezed
abstract class Transcript with _$Transcript {
  const factory Transcript({
    @JsonKey(name: 'date_id') required String dateId,
    // The analysis this date belongs to — so the viewer can watch the SAME
    // poller everyone else does for "other dates are still running".
    @JsonKey(name: 'analysis_id') required String analysisId,
    required String status,
    @JsonKey(name: 'setting_name') @Default('') String settingName,
    @Default('') String description,
    @JsonKey(name: 'sensory_details') @Default('') String sensoryDetails,
    @JsonKey(name: 'user_display_name') @Default('You') String userDisplayName,
    @JsonKey(name: 'candidate_display_name') @Default('') String candidateDisplayName,
    @JsonKey(name: 'schema_version') @Default('') String schemaVersion,
    @JsonKey(name: 'ended_by') String? endedBy,
    @Default(<TranscriptMessage>[]) List<TranscriptMessage> messages,
  }) = _Transcript;

  factory Transcript.fromJson(Map<String, dynamic> json) =>
      _$TranscriptFromJson(json);
}

// ---------------------------------------------------------------------------
// The rubric, verbatim (S13-U10)
// ---------------------------------------------------------------------------

/// The judge rubric's weights, copied from `app/judging.py` so the results
/// screen can show the arithmetic behind a score. Named trade: it exposes
/// that the weights are opinions — and that is the point. A bare "78" invites
/// blind trust or blind distrust; the breakdown invites reading the dates.
///
/// **v2 shipped on 2026-09-02 and this table did NOT have to grow a second
/// entry**, which is worth saying out loud since the note here promised it
/// would. v2 changed what the judge is TOLD — judge every date however short,
/// and report your own confidence — and added two fields. The four criteria
/// and their four weights are untouched, so a v1 score and a v2 score are the
/// same arithmetic over the same numbers and this table renders both
/// correctly. A version that changed a weight would still need its own entry.
const rubricVersionV1 = 'judge_rubric.v1';
const rubricVersionV2 = 'judge_rubric.v2';

class RubricCriterion {
  const RubricCriterion({
    required this.key,
    required this.label,
    required this.weight,
    required this.inverted,
    required this.plain,
  });

  final String key;
  final String label;
  final double weight;

  /// `clash_severity` is the ONE criterion where high is bad, so the score
  /// uses `100 - value` for it. Inverted at exactly one point on the server,
  /// and at exactly one point here.
  final bool inverted;

  /// Layman's terms (§26).
  final String plain;
}

const rubricWeights = <RubricCriterion>[
  RubricCriterion(
    key: 'trait_alignment',
    label: 'Acted like themselves',
    weight: 0.30,
    inverted: false,
    plain: 'How much each of you behaved like the traits in your profiles.',
  ),
  RubricCriterion(
    key: 'conversational_flow',
    label: 'Conversation flowed',
    weight: 0.30,
    inverted: false,
    plain: 'Whether it moved and built, or stalled and had to be restarted.',
  ),
  RubricCriterion(
    key: 'mutual_engagement',
    label: 'Both were in it',
    weight: 0.25,
    inverted: false,
    plain: 'One person delighted and one politely waiting scores low here.',
  ),
  RubricCriterion(
    key: 'clash_severity',
    label: 'Didn’t clash',
    weight: 0.15,
    inverted: true,
    plain: 'The one that is scored backwards: 0 clash is the best score.',
  ),
];

/// The score formula, verbatim from `date_simulation.md` §2. Pure so the
/// widget tests can check it against fixtures and the results screen can show
/// "this is the number you are looking at" rather than "trust us".
double dateScoreFromCriteria(Map<String, dynamic> criteria) {
  var total = 0.0;
  for (final c in rubricWeights) {
    final raw = (criteria[c.key] as num? ?? 0).toDouble();
    total += c.weight * (c.inverted ? 100 - raw : raw);
  }
  return total;
}

/// The weight a judged date carries in the candidate's mean (S12-B6).
const partialDateWeight = 0.5;

// ---------------------------------------------------------------------------
// Copy for how a date ended (S13-U8) — the server decided, the UI says it.
// ---------------------------------------------------------------------------

String endingSentence({required String status, required String? endedBy}) {
  return switch ((status, endedBy)) {
    (_, 'mutual_wants_to_end') => 'They both felt it was a natural place to stop.',
    (_, 'cap') => 'Time was up — the evening ran to its full length.',
    ('incomplete', _) => 'This date stopped early.',
    ('failed', _) => 'This date never got going.',
    ('running', _) => 'Still going…',
    ('pending', _) => 'Hasn’t started yet.',
    _ => 'The date finished.',
  };
}

/// Layman copy for why a date stopped early (S13-U2, U13). The technical
/// error string from the server is kept for a details view; this is the
/// sentence a person reads first.
String incompleteReason(DateSummary d) {
  final at = d.messageCount;
  final where = at == 0 ? 'before the first line' : 'after message $at';
  if (d.status == 'failed') return 'The date couldn’t start.';
  if (d.status != 'incomplete') return '';
  return 'Stopped $where — the AI stopped answering.';
}
