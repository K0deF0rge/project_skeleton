
import '../../../domain/models/user/user_model.dart';
import '../../../utils/result.dart';
import '../../services/api/supabase/api_service.dart';
import '../../services/api/supabase/filters.dart';
import '../../services/local/local_service.dart';
import '../../../domain/repositories/user/user_repository.dart';

class UserRepositoryRemote extends UserRepository {
  final LocalService<UserModel>? localService;
  final APIService<UserModel> apiService;

  UserRepositoryRemote({this.localService, required this.apiService}) : super(service: apiService);

  @override
  FutureResult<UserModel> getUser({required String id}) async {
    final userIdToFetch = id;
    final filters = [SupabaseFilter('id', FilterOperator.eq, userIdToFetch)];

    final userResult = await apiService.get(filters: filters, limit: 1, offset: 0);

    if (userResult is Error<Users>) return Result.error(userResult.error);

    final users = (userResult as Ok<Users>).value;

    if (users.isEmpty) {
      return Result.error(Exception('Usuário não encontrado'));
    }

    final model = users.first;

    if (localService != null) {
      final saveResult = await localService!.save(model, key: model.id);
      if (saveResult is Error) {
        return Result.error(saveResult.error);
      }
    }

    return Result.ok(model);
  }
  
  @override
  FutureResult<Users> getUsers() async {
    final result = await nextPage();
    if (result is Error<Users>) return result;
    final users = (result as Ok<Users>).value;

    if (localService != null) {
      final saveResult = await localService!.saveArray(users);
      if (saveResult is Error) {
        return Result.error(saveResult.error);
      }
    }

    return Result.ok(users);
  }
}
