import '../../../data/repositories/user/user_repository.dart';
import '../../../domain/models/user/user.dart';
import '../../../utils/command.dart';

class UsersViewmodel {
  final UserRepository userRepository;
  UsersViewmodel({required this.userRepository}) {
    getUsers = Command0<List<UserModel>>(userRepository.getUsers)..execute();
  }

  late Command0<List<UserModel>> getUsers;
}
