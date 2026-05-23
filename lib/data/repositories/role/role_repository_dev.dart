
import '../../../domain/models/role/role_model.dart';
import '../../../utils/result.dart';
import '../../../domain/repositories/role/role_repository.dart';

class RoleRepositoryDev extends RoleRepository {
  RoleRepositoryDev();

  @override
  FutureResult<Roles> getRolesByUserId(String userId) async {
    return Result.ok(<RoleModel>[
      RoleModel(
        0,
        userId: userId,
        module: Modules.users,
      ),
      RoleModel(
        0,
        userId: userId,
        module: Modules.products,
      ),
    ]);
  }
}
