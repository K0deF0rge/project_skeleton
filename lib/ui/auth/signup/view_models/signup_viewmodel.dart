
import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../data/services/api/supabase/auth_service.dart';
import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class SignupViewmodel {
  final AuthRepository authRepository;
  SignupViewmodel({required this.authRepository}) {
    signup = Command2<String, String, String>(_signUp);
  }

  late Command2<String, String, String> signup;

  FutureResult<String> _signUp(String email, String password) async {
    return await authRepository.signUp(SignCredentials(email: email, password: password));
  }
}
