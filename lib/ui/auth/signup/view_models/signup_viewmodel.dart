import '../../../../data/models/credentials.dart';
import '../../../../domain/use_cases/auth/auth_sign_up_use_case.dart';
import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class SignupViewmodel {
  SignupViewmodel({required AuthSignUpUseCase signUpUseCase})
    : _signUpUseCase = signUpUseCase {
    signup = Command1<void, Credentials>(_signUp);
  }

  final AuthSignUpUseCase _signUpUseCase;

  late Command1<void, Credentials> signup;

  FutureResultVoid _signUp(Credentials credentials) async {
    return await _signUpUseCase.execute(credentials);
  }
}
