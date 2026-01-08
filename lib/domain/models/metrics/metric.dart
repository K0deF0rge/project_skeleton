import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'metric.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Metric extends BaseModel {
  @JsonKey(required: true)
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Metric(
    this.id, {
    required this.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => _$MetricToJson(this);

  @override
  Metric toModel(Map<String, dynamic> json) => _$MetricFromJson(json);

  static Metric fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);
}
