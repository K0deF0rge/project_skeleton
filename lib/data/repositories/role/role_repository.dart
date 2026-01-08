
import '../../../domain/models/role/role.dart';
import '../../../utils/result.dart';

abstract class RoleRepository {
  RoleRepository();

  FutureResult<List<Role>> getRolesByUserId(String userId);
}
