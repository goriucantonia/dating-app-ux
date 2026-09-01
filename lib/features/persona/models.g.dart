// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonaSnapshot _$PersonaSnapshotFromJson(Map<String, dynamic> json) =>
    _PersonaSnapshot(
      snapshotId: json['snapshot_id'] as String,
      version: (json['version'] as num).toInt(),
      status: json['status'] as String,
      schemaVersion: json['schema_version'] as String,
      traitsHash: json['traits_hash'] as String,
      sourceTraitCount: (json['source_trait_count'] as num).toInt(),
      digestModel: json['digest_model'] as String?,
      error: json['error'] as String?,
      stale: json['stale'] as bool? ?? false,
    );

Map<String, dynamic> _$PersonaSnapshotToJson(_PersonaSnapshot instance) =>
    <String, dynamic>{
      'snapshot_id': instance.snapshotId,
      'version': instance.version,
      'status': instance.status,
      'schema_version': instance.schemaVersion,
      'traits_hash': instance.traitsHash,
      'source_trait_count': instance.sourceTraitCount,
      'digest_model': instance.digestModel,
      'error': instance.error,
      'stale': instance.stale,
    };

_PersonaState _$PersonaStateFromJson(Map<String, dynamic> json) =>
    _PersonaState(
      snapshot: json['snapshot'] == null
          ? null
          : PersonaSnapshot.fromJson(json['snapshot'] as Map<String, dynamic>),
      simulatable: json['simulatable'] as bool,
    );

Map<String, dynamic> _$PersonaStateToJson(_PersonaState instance) =>
    <String, dynamic>{
      'snapshot': instance.snapshot,
      'simulatable': instance.simulatable,
    };
