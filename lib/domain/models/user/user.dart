import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enums/user_role.dart';
import '../base.dart';
import '../role/role.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends BaseModel {
  @JsonKey(required: true)
  final String id;
  @JsonKey(defaultValue: "")
  String number;
  @JsonKey(defaultValue: "")
  String name;
  @JsonKey(defaultValue: "")
  String email;
  @JsonKey(defaultValue: UserRole.user)
  UserRole role;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<Role> roles;

  set roles(List<Role> newRoles) {
    roles.clear();
    roles.addAll(newRoles);
  }

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

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
      orElse: () => Role(0, module: module, userId: ''),
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
