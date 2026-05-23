import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enums/modules.dart';
import '../base.dart';

export '../../../utils/enums/modules.dart';

part 'role_model.g.dart';

typedef Roles = List<RoleModel>;

@JsonSerializable(fieldRename: FieldRename.snake)
class RoleModel extends BaseModel {
  @JsonKey(required: true)
  final int id;
  final String userId;
  final Modules module;
  @JsonKey(defaultValue: false)
  final bool canRead;
  @JsonKey(defaultValue: false)
  final bool canWrite;
  @JsonKey(defaultValue: false)
  final bool canDelete;

  RoleModel(
    this.id, {
    required this.userId,
    required this.module,
    this.canRead = false,
    this.canWrite = false,
    this.canDelete = false,
  });

  bool get isFullAccess => canRead && canWrite && canDelete;

  @override
  Map<String, dynamic> toJson() => _$RoleModelToJson(this);

  @override
  RoleModel toModel(Map<String, dynamic> json) => _$RoleModelFromJson(json);

  static RoleModel fromJson(Map<String, dynamic> json) => _$RoleModelFromJson(json);

  static String getTableName() => 'roles';
}
