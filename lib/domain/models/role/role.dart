import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enums/modules.dart';
import '../base.dart';

export '../../../utils/enums/modules.dart';

part 'role.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Role extends BaseModel {
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

  Role(
    this.id, {
    required this.userId,
    required this.module,
    this.canRead = false,
    this.canWrite = false,
    this.canDelete = false,
  });

  bool get isFullAccess => canRead && canWrite && canDelete;

  @override
  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  Role toModel(Map<String, dynamic> json) => _$RoleFromJson(json);

  static Role fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  static String getTableName() => 'roles';
}
