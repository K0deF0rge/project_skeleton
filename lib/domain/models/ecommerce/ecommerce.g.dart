// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecommerce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ecommerce _$EcommerceFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'status']);
  return Ecommerce(
    (json['id'] as num).toInt(),
    createdAt: DateTime.parse(json['created_at'] as String),
    apiKey: json['api_key'] as String?,
    name: json['name'] as String?,
    status: $enumDecode(_$EcommerceStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$EcommerceToJson(Ecommerce instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'api_key': instance.apiKey,
  'name': instance.name,
  'status': _$EcommerceStatusEnumMap[instance.status]!,
};

const _$EcommerceStatusEnumMap = {
  EcommerceStatus.pending: 'pending',
  EcommerceStatus.active: 'active',
  EcommerceStatus.inactive: 'inactive',
};
