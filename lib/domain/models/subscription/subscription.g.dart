// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'user_id', 'plan_id', 'status']);
  return Subscription(
    (json['id'] as num).toInt(),
    createdAt: DateTime.parse(json['created_at'] as String),
    userId: json['user_id'] as String,
    planId: (json['plan_id'] as num).toInt(),
    status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'user_id': instance.userId,
      'plan_id': instance.planId,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
    };

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.pending: 'pending',
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.cancelled: 'cancelled',
};
