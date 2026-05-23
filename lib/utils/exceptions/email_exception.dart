import '../../ui/core/localization/applocalization.dart';

class EmailException implements Exception {
  final LocalizationKey localizationKey;
  EmailException(this.localizationKey);

  @override
  String toString() => localizationKey.name;
}