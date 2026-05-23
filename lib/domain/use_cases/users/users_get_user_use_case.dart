import 'package:logging/logging.dart';

import '../../../utils/result.dart';
import '../../models/role/role_model.dart';
import '../../models/user/user_model.dart';
import '../../repositories/role/role_repository.dart';
import '../../repositories/user/user_repository.dart';

class UsersGetUserUseCase {
  final UserRepository userRepository;
  final RoleRepository roleRepository;
  UsersGetUserUseCase({
    required this.userRepository,
    required this.roleRepository,
  });

  final _log = Logger('UsersGetUserUseCase');

  FutureResult<UserModel> execute(String id) async {
    final getUserResult = await userRepository.getUser(id: id);

    UserModel userModel;

    if (getUserResult is Error<UserModel>) {
      _log.warning('Get user failed: ${getUserResult.error}');
      return Result.error(getUserResult.error);
    }

    userModel = (getUserResult as Ok<UserModel>).value;
    _log.info('Get user success: ${userModel.toJson()}');
    final getUserRolesResult = await roleRepository.getRolesByUserId(id);

    if (getUserRolesResult is Error<Roles>) {
      _log.warning('Get user roles failed: ${getUserRolesResult.error}');
      return Result.error(getUserRolesResult.error);
    }

    userModel.roles = (getUserRolesResult as Ok<Roles>).value;

    return Result.ok(userModel);
  }
}
