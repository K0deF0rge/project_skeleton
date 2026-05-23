
import '../../models/role/role_model.dart';
import '../../../utils/result.dart';

abstract class RoleRepository {
  RoleRepository();

  FutureResult<Roles> getRolesByUserId(String userId);
}
