// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ecommerce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEcommerce _$UserEcommerceFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'user_id', 'ecommerce_id', 'status'],
  );
  return UserEcommerce(
    (json['id'] as num).toInt(),
    createdAt: DateTime.parse(json['created_at'] as String),
    userId: json['user_id'] as String,
    ecommerceId: (json['ecommerce_id'] as num).toInt(),
    status: $enumDecode(_$UserEcommerceStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$UserEcommerceToJson(UserEcommerce instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'user_id': instance.userId,
      'ecommerce_id': instance.ecommerceId,
      'status': _$UserEcommerceStatusEnumMap[instance.status]!,
    };

const _$UserEcommerceStatusEnumMap = {
  UserEcommerceStatus.pending: 'pending',
  UserEcommerceStatus.active: 'active',
  UserEcommerceStatus.inactive: 'inactive',
};
