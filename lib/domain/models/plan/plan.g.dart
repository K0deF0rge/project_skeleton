// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'status']);
  return Plan(
    (json['id'] as num).toInt(),
    createdAt: DateTime.parse(json['created_at'] as String),
    status: $enumDecode(_$PlanStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'status': _$PlanStatusEnumMap[instance.status]!,
};

const _$PlanStatusEnumMap = {
  PlanStatus.disabled: 'disabled',
  PlanStatus.active: 'active',
  PlanStatus.expired: 'expired',
};
