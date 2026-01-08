import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';
import '../paginator_repository.dart';

abstract class UserRepository extends RepositoryPaginator<UserModel> {
  UserRepository({required super.service});

  Future<Result<UserModel>> getUser({required String id});
  Future<Result<List<UserModel>>> getUsers();
}
