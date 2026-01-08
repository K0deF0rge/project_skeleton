// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Metric _$MetricFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return Metric(
    (json['id'] as num).toInt(),
    createdAt: DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$MetricToJson(Metric instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
};
