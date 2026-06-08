import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enums/user_role.dart';
import '../base.dart';
import '../role/role_model.dart';

part 'user_model.g.dart';

typedef Users = List<UserModel>;

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends BaseModel {
  @JsonKey(required: true)
  final String id;
  @JsonKey(defaultValue: "")
  final String number;
  @JsonKey(defaultValue: "")
  final String name;
  @JsonKey(defaultValue: "")
  final String email;
  @JsonKey(defaultValue: UserRole.user)
  final UserRole role;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Roles roles;

  void setRoles(Roles newRoles) {
    roles.clear();
    roles.addAll(newRoles);
  }

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  UserModel(
    this.id, {
    required this.number,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.role, 
    this.roles = const [],
  });

  String get display => (name.isNotEmpty) ? name : email;

  bool hasPermission(Modules module, {bool read = false, bool write = false, bool del = false}) {
    final perm = roles.firstWhere(
      (p) => p.module == module,
      orElse: () => RoleModel(0, module: module, userId: ''),
    );

    if (role == UserRole.owner) return true;

    return (!read || perm.canRead) &&
           (!write || perm.canWrite) &&
           (!del || perm.canDelete);
  }

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  UserModel toModel(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);


  static String getTableName() => 'users';
}
