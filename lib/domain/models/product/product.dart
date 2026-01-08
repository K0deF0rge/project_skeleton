import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'product.g.dart';

enum ProductStatus { active, inactive, archived }

@JsonSerializable(fieldRename: FieldRename.snake)
class Product extends BaseModel {
  @JsonKey(required: true)
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(required: true)
  final ProductStatus status;

  Product(
    this.id, {
    required this.createdAt,
    this.updatedAt,
    required this.status,
  });

  @override
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  Product toModel(Map<String, dynamic> json) => _$ProductFromJson(json);

  static Product fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
