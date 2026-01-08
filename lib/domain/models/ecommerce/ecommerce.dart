import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'ecommerce.g.dart';

enum EcommerceStatus { pending, active, inactive }

@JsonSerializable(fieldRename: FieldRename.snake)
class Ecommerce extends BaseModel {
  @JsonKey(required: true)
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final String? apiKey;
  final String? name;
  @JsonKey(required: true)
  final EcommerceStatus status;

  Ecommerce(
    this.id, {
    required this.createdAt,
    this.apiKey,
    this.name,
    required this.status,
  });

  @override
  Map<String, dynamic> toJson() => _$EcommerceToJson(this);

  @override
  Ecommerce toModel(Map<String, dynamic> json) => _$EcommerceFromJson(json);

  static Ecommerce fromJson(Map<String, dynamic> json) => _$EcommerceFromJson(json);
}
