import '../../../domain/models/user/user_model.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/result.dart';
import '../../models/credentials.dart';
import '../../models/user_state.dart';
import '../../../domain/repositories/auth/auth_repository.dart';

class AuthRepositoryDev extends AuthRepository {
  @override
  Result<UserState> fetchUser() {
    return Result.ok(
      UserLogged(
        UserModel(
          'uuid_dev_user',
          email: 'dev@gmail.com',
          number: '61999999999',
          name: 'dev',
          updatedAt: DateTime.now(),
          createdAt: DateTime.now(),
          role: UserRole.owner,
        ),
      ),
    );
  }

  @override
  FutureResult<String> signIn(Credentials credentials) async {
    userState.value = UserLogged((fetchUser() as Ok<UserModel>).value);
    return Result.ok('uuid_dev_user');
  }

  // @override
  // Future<Result<String>> signInWithOtp({required String email}) async {
  //   return const Result.ok("");
  // }

  @override
  FutureResult<String> signUp(Credentials credentials) async {
    return const Result.ok('uuid_dev');
  }

  @override
  FutureResultVoid signOut() async {
    userState.value = UserUnlogged();
    return const Result.ok(null);
  }

  @override
  FutureResultVoid resetPassword(Credentials credentials) async {
    return Future.value(Result.ok(null));
  }

  @override
  FutureResultVoid addAuthStateListener(
    void Function() listener, {
    bool cancelOnError = false,
  }) async {
    return const Result.ok(null);
  }

  @override
  FutureResultVoid removeAuthStateListener(void Function() onAuthStateChange) async {
    return const Result.ok(null);
  }

  @override
  FutureResultVoid setUserState(UserState newState) async {
    userState.value = newState;
    return const Result.ok(null);
  }
}
