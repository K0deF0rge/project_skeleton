import '../../../../data/models/credentials.dart';
import '../../../../domain/use_cases/auth/auth_reset_password_use_case.dart';
import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class ResetPasswordViewmodel {
  ResetPasswordViewmodel({
    required AuthResetPasswordUseCase resetPasswordUseCase,
  }) : _resetPasswordUseCase = resetPasswordUseCase {
    resetPassword = Command1<void, String>(_resetPassword);
  }

  final AuthResetPasswordUseCase _resetPasswordUseCase;

  late Command1<void, String> resetPassword;

  FutureResultVoid _resetPassword(String email) async {
    return await _resetPasswordUseCase.execute(
      Credentials(email: email, password: ''),
    );
  }
}
