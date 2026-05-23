import '../../../../data/models/credentials.dart';
import '../../../../domain/use_cases/auth/auth_sign_in_use_case.dart';
import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class SigninViewmodel {
  SigninViewmodel({required AuthSignInUseCase signInUseCase})
    : _signInUseCase = signInUseCase {
    signin = Command1<void, Credentials>(_signIn);
  }

  final AuthSignInUseCase _signInUseCase;

  late Command1<void, Credentials> signin;

  FutureResultVoid _signIn(Credentials credentials) async {
    return await _signInUseCase.execute(credentials);
  }

  // Future<Result<String>> _signInWithOtp(String email) async {
  //   final result = await _authRepository.signInWithOtp(email: email);

  //   return result;
  // }
}
