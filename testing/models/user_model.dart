import 'package:project_skeleton/domain/models/role/role_model.dart';
import 'package:project_skeleton/domain/models/user/user_model.dart';
import 'package:project_skeleton/utils/enums/user_role.dart';

const String uuidDevUser1 = 'uuid_dev_user_1';
const String uuidDevUser2 = 'uuid_dev_user_2';
const String uuidDevUser3 = 'uuid_dev_user_3';

const String nameDevUser1 = 'User 1';
const String nameDevUser2 = 'User 2';
const String nameDevUser3 = 'User 3';

final kUserModel = UserModel(
  uuidDevUser1,
  name: nameDevUser1,
  email: 'user1@example.com',
  number: '',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  role: UserRole.owner,
);

final kUserModels = [
  UserModel(
    uuidDevUser2,
    name: nameDevUser2,
    email: 'user2@example.com',
    number: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    role: UserRole.user,
  ),
  UserModel(
    uuidDevUser3,
    name: nameDevUser3,
    email: 'user3@example.com',
    number: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    role: UserRole.user,
  ),
];

final kRoleModels = [
  RoleModel(1, userId: uuidDevUser1, module: Modules.users),
  RoleModel(2, userId: uuidDevUser1, module: Modules.products),
];
