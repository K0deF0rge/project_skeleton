import 'package:logging/logging.dart';

import '../../../data/models/user_state.dart';
import '../../../utils/result.dart';
import '../../../utils/validators/credentials_validator.dart';
import '../../models/role/role_model.dart';
import '../../models/user/user_model.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../repositories/role/role_repository.dart';
import '../../repositories/user/user_repository.dart';

class AuthSignInUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final RoleRepository roleRepository;
  AuthSignInUseCase({
    required this.authRepository,
    required this.userRepository,
    required this.roleRepository,
  });

  final _log = Logger('AuthSignInUseCase');

  FutureResultVoid execute(Credentials credentials) async {
    final credentialsException = CredentialsValidator.validate(credentials);
    if (credentialsException != null) {
      _log.warning('Credentials validation failed: $credentialsException');
      return Result.error(credentialsException);
    }

    final resultSignIn = await authRepository.signIn(credentials);

    if (resultSignIn is Error<String>) {
      _log.warning('Sign-in failed: ${resultSignIn.error}');
      return resultSignIn;
    }

    final userId = (resultSignIn as Ok<String>).value;

    final userResult = await userRepository.getUser(id: userId);

    if (userResult is Error<UserModel>) {
      _log.warning('get user failed: ${userResult.error}');
      return userResult;
    }

    final userModel = (userResult as Ok<UserModel>).value;

    final roleResult = await roleRepository.getRolesByUserId(userId);

    if (roleResult is Error<Roles>) {
      _log.warning('get roles failed: ${roleResult.error}');

      return roleResult;
    }

    userModel.roles = (roleResult as Ok<Roles>).value;

    final resultSetUserState = await authRepository.setUserState(
      UserLogged(userModel),
    );

    if (resultSetUserState is Error) {
      _log.warning('set user state failed: ${resultSetUserState.error}');
      return resultSetUserState;
    }

    return const Result.ok(null);
  }
}
