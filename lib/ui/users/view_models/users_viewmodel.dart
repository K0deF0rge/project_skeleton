import '../../../domain/repositories/user/user_repository.dart';
import '../../../domain/models/user/user_model.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class UsersViewmodel {
  UsersViewmodel({required UserRepository userRepository}) 
  : _userRepository = userRepository {
    getUsers = Command0<Users>(_getUsers)..execute();
  }

  final UserRepository _userRepository;

  late Command0<Users> getUsers;

  FutureResult<Users> _getUsers() async {
    final resultGetUsers = await _userRepository.getUsers();
    if (resultGetUsers is Error<Users>) {
      return Result.error(resultGetUsers.error);
    }
    return Result.ok((resultGetUsers as Ok<Users>).value);
  }
}
