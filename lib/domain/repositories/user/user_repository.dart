import '../../models/user/user_model.dart';
import '../../../utils/result.dart';
import '../../../data/repositories/paginator_repository.dart';

abstract class UserRepository extends RepositoryPaginator<UserModel> {
  UserRepository({required super.service});

  FutureResult<UserModel> getUser({required String id});
  FutureResult<Users> getUsers();
}
