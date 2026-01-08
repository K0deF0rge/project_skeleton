import '../../../domain/models/user/user.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/result.dart';
import '../../model/sign_credentials.dart';
import '../../model/user_state.dart';
import 'auth_repository.dart';

class AuthRepositoryDev extends AuthRepository {
  @override
  Future<Result<String>> signInWithOtp({required String email}) async {
    return const Result.ok("");
  }

  @override
  Future<Result<void>> signOut() async {
    userState.value = UserUnlogged();
    return const Result.ok(null);
  }

  @override
  FutureResult<String> signIn(SignCredentials credentials) async {
    userState.value = UserLogged((fetchUser() as Ok<UserModel>).value);
    return Result.ok('Login bem-sucedido (dev)');
  }

  @override
  Result<UserModel> fetchUser() {
    return Result.ok(
      UserModel(
        'dev_user',
        email: 'dev@gmail.com',
        number: '61999999999',
        name: 'dev',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        role: UserRole.owner,
      ),
    );
  }

  @override
  Future<Result<String>> resetPassword(String email) {
    return Future.value(const Result.ok('success'));
  }

  @override
  FutureResult<String> signUp(SignCredentials credentials) async {
    return const Result.ok('Cadastro bem-sucedido (dev)');
  }

  @override
  Future<Result<void>> addAuthStateListener(
    void Function() listener, {
    bool cancelOnError = false,
  }) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> removeAuthStateListener(void Function() onAuthStateChange) async {
    return const Result.ok(null);
  }
}
