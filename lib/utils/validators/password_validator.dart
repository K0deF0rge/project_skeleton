import '../exceptions/password_exception.dart';

enum ResultPasswordValidator {
  emptyPassword('Digite uma senha'),
  shortPassword('A senha deve ter no mínimo 8 caracteres'),
  noUpperCase('A senha deve conter pelo menos uma letra maiúscula'),
  noLowerCase('A senha deve conter pelo menos uma letra minúscula'),
  noNumber('A senha deve conter pelo menos um número'),
  noSpecialChar('A senha deve conter pelo menos um caractere especial (!@#\$%^&*)'),
  validPassword('Senha válida');

  final String text;
  const ResultPasswordValidator(this.text);
}

class PasswordValidator {
  static PasswordException? validate(String? password) {
    if (password == null || password.isEmpty) {
      return PasswordException(ResultPasswordValidator.emptyPassword.text);
    }

    if (password.length < 8) {
      return PasswordException(ResultPasswordValidator.shortPassword.text);
    }

    if (!_hasUpperCase(password)) {
      return PasswordException(ResultPasswordValidator.noUpperCase.text);
    }

    if (!_hasLowerCase(password)) {
      return PasswordException(ResultPasswordValidator.noLowerCase.text);
    }

    if (!_hasNumber(password)) {
      return PasswordException(ResultPasswordValidator.noNumber.text);
    }

    if (!_hasSpecialChar(password)) {
      return PasswordException(ResultPasswordValidator.noSpecialChar.text);
    }

    return null;
  }

  static String? validator(String? password) {
    final exception = validate(password);
    return exception?.message;
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

