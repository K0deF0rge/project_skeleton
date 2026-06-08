import 'dart:collection';

import '../../../domain/models/role/role_model.dart';
import '../../../utils/result.dart';
import '../../services/api/supabase/api_service.dart';
import '../../services/api/supabase/filters.dart';
import '../../services/local/local_service.dart';
import '../../../domain/repositories/role/role_repository.dart';

class RoleRepositoryRemote extends RoleRepository {
  RoleRepositoryRemote({
    required APIService<RoleModel> apiService,
    LocalService<RoleModel>? localService,
  }) : _apiService = apiService,
       _localService = localService;

  final APIService<RoleModel> _apiService;
  final LocalService<RoleModel>? _localService;

  List<SupabaseFilter> _filters = [];

  set filters(List<SupabaseFilter> filters) => _filters = filters;

  List<SupabaseFilter> get filters => UnmodifiableListView(_filters);

  @override
  FutureResult<Roles> getRolesByUserId(String userId) async {
    filters = [SupabaseFilter('user_id', FilterOperator.eq, userId)];

    final result = await _apiService.get(
      filters: filters,
      noLimit: true,
    );
    if (result is Error<Roles>) return Result.error(result.error);

    final roles = (result as Ok<Roles>).value;

    if (_localService != null) {
      final res = await _localService.saveArray(roles, key: userId);

      if (res is Error) return Result.error(res.error);
    }

    return Result.ok(roles);
  }
}
