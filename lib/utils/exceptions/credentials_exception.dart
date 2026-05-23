import '../../ui/core/localization/applocalization.dart';

class CredentialsException implements Exception {
  final LocalizationKey localizationKey;
  CredentialsException(this.localizationKey);

  @override
  String toString() => localizationKey.name;
}
