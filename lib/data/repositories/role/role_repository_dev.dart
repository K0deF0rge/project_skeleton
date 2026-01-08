
import '../../../domain/models/role/role.dart';
import '../../../utils/result.dart';
import 'role_repository.dart';

class RoleRepositoryDev extends RoleRepository {
  RoleRepositoryDev();

  @override
  FutureResult<List<Role>> getRolesByUserId(String userId) async {
    return Result.ok(<Role>[
      Role(
        0,
        userId: userId,
        module: Modules.users,
      ),
      Role(
        0,
        userId: userId,
        module: Modules.products,
      ),
    ]);
  }
}
