
import '../../../domain/models/role/role_model.dart';
import '../../../utils/result.dart';
import '../../services/api/supabase/api_service.dart';
import '../../services/api/supabase/filters.dart';
import '../../services/local/local_service.dart';
import '../../../domain/repositories/role/role_repository.dart';

class RoleRepositoryRemote extends RoleRepository {
  final APIService<RoleModel> apiService;
  LocalService<RoleModel>? localService;
  RoleRepositoryRemote({required this.apiService, this.localService});

  @override
  FutureResult<Roles> getRolesByUserId(String userId) async {
    final result = await apiService.get(filters: [SupabaseFilter('user_id', SupabaseOperator.eq, userId)], noLimit: true);
    if (result is Error<Roles>) return Result.error(result.error);

    final roles = (result as Ok<Roles>).value;

    if (localService != null) {
      final res = await localService!.saveArray(roles, key: userId);

      if (res is Error) return Result.error(res.error);
    }

    return Result.ok(roles);
  }
}
