import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// Snapshot METADATA. There is deliberately no `systemPrompt` field: the
/// server never sends it (trait_persona.md §7.5) because it embeds the user's
/// raw answers, and a field here would be an invitation to start sending it.
@freezed
abstract class PersonaSnapshot with _$PersonaSnapshot {
  const factory PersonaSnapshot({
    @JsonKey(name: 'snapshot_id') required String snapshotId,
    required int version,
    required String status, // compiling | ready | failed
    @JsonKey(name: 'schema_version') required String schemaVersion,
    @JsonKey(name: 'traits_hash') required String traitsHash,
    @JsonKey(name: 'source_trait_count') required int sourceTraitCount,
    @JsonKey(name: 'digest_model') String? digestModel,
    String? error,
    @Default(false) bool stale,
  }) = _PersonaSnapshot;

  factory PersonaSnapshot.fromJson(Map<String, dynamic> json) =>
      _$PersonaSnapshotFromJson(json);
}

@freezed
abstract class PersonaState with _$PersonaState {
  const factory PersonaState({
    PersonaSnapshot? snapshot,
    required bool simulatable,
  }) = _PersonaState;

  factory PersonaState.fromJson(Map<String, dynamic> json) =>
      _$PersonaStateFromJson(json);
}
