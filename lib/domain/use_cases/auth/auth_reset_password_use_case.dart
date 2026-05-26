import 'package:logging/logging.dart';

import '../../../utils/result.dart';
import '../../../utils/validators/credentials_validator.dart';
import '../../repositories/auth/auth_repository.dart';

class AuthResetPasswordUseCase {
  final AuthRepository authRepository;
  AuthResetPasswordUseCase({required this.authRepository});

  final _log = Logger('AuthResetPasswordUseCase');

  FutureResultVoid execute(Credentials credentials) async {
    final emailException = EmailValidator.validate(credentials.email);
    if (emailException != null) {
      _log.warning('Email validation failed: $emailException');
      return Result.error(emailException);
    }

    final resetPasswordResult = await authRepository.resetPassword(credentials);

    if (resetPasswordResult is Error) {
      _log.warning('Reset password failed: ${resetPasswordResult.error}');
      return resetPasswordResult;
    }

    return const Result.ok(null);
  }
}
