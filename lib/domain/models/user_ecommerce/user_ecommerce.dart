import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'user_ecommerce.g.dart';

enum UserEcommerceStatus { pending, active, inactive }

@JsonSerializable(fieldRename: FieldRename.snake)
class UserEcommerce extends BaseModel {
  @JsonKey(required: true)
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(required: true)
  final String userId;
  @JsonKey(required: true)
  final int ecommerceId;
  @JsonKey(required: true)
  final UserEcommerceStatus status;

  UserEcommerce(
    this.id, {
    required this.createdAt,
    required this.userId,
    required this.ecommerceId,
    required this.status,
  });

  @override
  Map<String, dynamic> toJson() => _$UserEcommerceToJson(this);

  @override
  UserEcommerce toModel(Map<String, dynamic> json) => _$UserEcommerceFromJson(json);

  static UserEcommerce fromJson(Map<String, dynamic> json) => _$UserEcommerceFromJson(json);
}
