import '../../ui/core/localization/applocalization.dart';
import '../exceptions/email_exception.dart';

class EmailValidator {
  static const String _emailRegexPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  static final RegExp _emailRegex = RegExp(_emailRegexPattern);

  static EmailException? validate(
    String? email,
  ) {
    final LocalizationKey? invalidKey = _isInvalid(email);
    if (invalidKey != null) {
      return EmailException(invalidKey);
    }

    return null;
  }

  static LocalizationKey? validator(
    String? email,
  ) {
    return _isInvalid(email);
  }

  static LocalizationKey? _isInvalid(String? email) {
    if (email == null || email.isEmpty) return LocalizationKey.emailEmptyError;
    if (!_emailRegex.hasMatch(email)) return LocalizationKey.emailInvalidError;
    return null;
  }
}
