import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'product_ecommerce.g.dart';

enum ProductEcommerceStatus { pending, active, inactive }

@JsonSerializable(fieldRename: FieldRename.snake)
class RoleProductEcommerce extends BaseModel {
  @JsonKey(required: true)
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(required: true)
  final int productId;
  @JsonKey(required: true)
  final int ecommerceId;
  @JsonKey(required: true)
  final ProductEcommerceStatus status;

  RoleProductEcommerce(
    this.id, {
    required this.createdAt,
    required this.productId,
    required this.ecommerceId,
    required this.status,
  });

  @override
  Map<String, dynamic> toJson() => _$RoleProductEcommerceToJson(this);

  @override
  RoleProductEcommerce toModel(Map<String, dynamic> json) => _$RoleProductEcommerceFromJson(json);

  static RoleProductEcommerce fromJson(Map<String, dynamic> json) => _$RoleProductEcommerceFromJson(json);
}
