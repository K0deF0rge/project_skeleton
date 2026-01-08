
import '../../../../data/model/sign_credentials.dart';
import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class SigninViewmodel {
  SigninViewmodel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    signin = Command2<String, String, String>(_signIn);
  }

  final AuthRepository _authRepository;

  late Command2<String, String, String> signin;

  Future<Result<String>> _signIn(String email, String password) async {
    final result = await _authRepository.signIn(SignCredentials(email: email, password: password));

    return result;
  }

  // Future<Result<String>> _signInWithOtp(String email) async {
  //   final result = await _authRepository.signInWithOtp(email: email);

  //   return result;
  // }
}
