import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class ResetPasswordViewmodel {
  final AuthRepository authRepository;
  ResetPasswordViewmodel({required this.authRepository}) {
    reset = Command1<String, String>(_resetPassword);
  }

  late Command1<String, String> reset;

  Future<Result<String>> _resetPassword(String email) async {
    return await authRepository.resetPassword(email);
  }
}
