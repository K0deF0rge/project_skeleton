import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'plan.g.dart';

enum PlanStatus { disabled, active, expired }

@JsonSerializable(fieldRename: FieldRename.snake)
class Plan extends BaseModel {
  @JsonKey(required: true)
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(required: true)
  final PlanStatus status;

  Plan(
    this.id, {
    required this.createdAt,
    required this.status,
  });

  @override
  Map<String, dynamic> toJson() => _$PlanToJson(this);

  @override
  Plan toModel(Map<String, dynamic> json) => _$PlanFromJson(json);

  static Plan fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}
