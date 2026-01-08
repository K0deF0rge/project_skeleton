import '../../../core/logger.dart';
import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';
import '../../services/api/supabase/api_service.dart';
import '../../services/api/supabase/filters.dart';
import '../../services/local/local_service.dart';
import 'user_repository.dart';

class UserRepositoryRemote extends UserRepository {
  final LocalService<UserModel>? localService;
  final APIService<UserModel> apiService;

  UserRepositoryRemote({this.localService, required this.apiService}) : super(service: apiService);

  @override
  Future<Result<UserModel>> getUser({required String id}) async {
    final userIdToFetch = id;
    final filters = [SupabaseFilter('id', SupabaseOperator.eq, userIdToFetch)];
    AppLogger.debug("\n!!!UserRepositoryRemote: $filters $userIdToFetch !!!");
    final userResult = await apiService.get(filters: filters, limit: 1, offset: 0);
    AppLogger.debug("UserRepositoryRemote: userResult $userResult");
    if (userResult is Error) return Result.error((userResult as Error).error);

    final users = (userResult as Ok<List<UserModel>>).value;
    AppLogger.debug("UserRepositoryRemote: users ${users.length}");
    if (users.isEmpty) {
      return Result.error(Exception('Usuário(s) não encontrado(s)'));
    }

    final model = users.first;

    AppLogger.debug("UserRepositoryRemote: model ${model.toJson()}");

    if (localService != null) {
      final saveResult = await localService!.save(model, key: model.id);
      if (saveResult is Error) {
        return Result.error(saveResult.error);
      }
    }

    return Result.ok(model);
  }
  
  @override
  Future<Result<List<UserModel>>> getUsers() async {
    final result = await nextPage();
    if (result is Error<List<UserModel>>) return Result.error(result.error);
    final users = (result as Ok<List<UserModel>>).value;

    if (localService != null) {
      final saveResult = await localService!.saveArray(users);
      if (saveResult is Error) {
        return Result.error(saveResult.error);
      }
    }

    return Result.ok(users);
  }
}
