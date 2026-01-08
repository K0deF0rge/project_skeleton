
import '../../../domain/models/role/role.dart';
import '../../../utils/result.dart';
import '../../services/api/supabase/api_service.dart';
import '../../services/api/supabase/filters.dart';
import '../../services/local/local_service.dart';
import 'role_repository.dart';

class RoleRepositoryRemote extends RoleRepository {
  final APIService<Role> service;
  LocalService<Role>? localService;
  RoleRepositoryRemote({required this.service, this.localService});

  @override
  FutureResult<List<Role>> getRolesByUserId(String userId) async {
    final result = await service.get(filters: [SupabaseFilter('user_id', SupabaseOperator.eq, userId)], noLimit: true);
    if (result is Error<List<Role>>) return Result.error(result.error);

    final roles = (result as Ok<List<Role>>).value;

    if (localService != null) {
      final res = await localService!.saveArray(roles, key: userId);

      if (res is Error) return Result.error(res.error);
    }

    return Result.ok(roles);
  }
}
