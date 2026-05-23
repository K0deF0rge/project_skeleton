import '../../ui/core/localization/applocalization.dart';
import '../exceptions/password_exception.dart';

class PasswordValidator {
  static PasswordException? validate(String? password) {
    if (password == null || password.isEmpty) {
      return PasswordException(LocalizationKey.passwordEmptyError);
    }

    if (password.length < 8) {
      return PasswordException(LocalizationKey.passwordShortError);
    }

    if (!_hasUpperCase(password)) {
      return PasswordException(LocalizationKey.passwordNoUpperCaseError);
    }

    if (!_hasLowerCase(password)) {
      return PasswordException(LocalizationKey.passwordNoLowerCaseError);
    }

    if (!_hasNumber(password)) {
      return PasswordException(LocalizationKey.passwordNoNumberError);
    }

    if (!_hasSpecialChar(password)) {
      return PasswordException(LocalizationKey.passwordNoSpecialCharError);
    }

    return null;
  }

  static LocalizationKey? validator(String? password) {
    final exception = validate(password);
    return exception?.localizationKey;
  }

  static bool _hasUpperCase(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }

  static bool _hasLowerCase(String password) {
    return password.contains(RegExp(r'[a-z]'));
  }

  static bool _hasNumber(String password) {
    return password.contains(RegExp(r'[0-9]'));
  }

  static bool _hasSpecialChar(String password) {
    return password.contains(RegExp(r'[!@#\$%^&*]'));
  }
}
