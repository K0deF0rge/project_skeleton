// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_ecommerce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleProductEcommerce _$RoleProductEcommerceFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'product_id', 'ecommerce_id', 'status'],
  );
  return RoleProductEcommerce(
    (json['id'] as num).toInt(),
    createdAt: DateTime.parse(json['created_at'] as String),
    productId: (json['product_id'] as num).toInt(),
    ecommerceId: (json['ecommerce_id'] as num).toInt(),
    status: $enumDecode(_$ProductEcommerceStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$RoleProductEcommerceToJson(
  RoleProductEcommerce instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'product_id': instance.productId,
  'ecommerce_id': instance.ecommerceId,
  'status': _$ProductEcommerceStatusEnumMap[instance.status]!,
};

const _$ProductEcommerceStatusEnumMap = {
  ProductEcommerceStatus.pending: 'pending',
  ProductEcommerceStatus.active: 'active',
  ProductEcommerceStatus.inactive: 'inactive',
};
