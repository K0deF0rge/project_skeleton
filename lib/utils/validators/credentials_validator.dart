import '../../data/models/credentials.dart';
import '../exceptions/credentials_exception.dart';
import 'email_validator.dart';
import 'password_validator.dart';

export 'email_validator.dart';
export 'password_validator.dart';
export '../../data/models/credentials.dart';
export '../exceptions/credentials_exception.dart';

class CredentialsValidator {
  static CredentialsException? validate(Credentials credentials) {
    final emailException = EmailValidator.validate(credentials.email);
    if (emailException != null) {
      return CredentialsException(emailException.localizationKey);
    }

    final passwordException = PasswordValidator.validate(credentials.password);
    if (passwordException != null) {
      return CredentialsException(passwordException.localizationKey);
    }

    return null;
  } 
}