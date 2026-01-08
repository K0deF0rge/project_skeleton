import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'subscription.g.dart';

enum SubscriptionStatus { pending, active, cancelled }

@JsonSerializable(fieldRename: FieldRename.snake)
class Subscription extends BaseModel {
  @JsonKey(required: true)
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(required: true)
  final String userId;
  @JsonKey(required: true)
  final int planId;
  @JsonKey(required: true)
  final SubscriptionStatus status;

  Subscription(
    this.id, {
    required this.createdAt,
    required this.userId,
    required this.planId,
    required this.status,
  });

  @override
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  @override
  Subscription toModel(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

  static Subscription fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
}
