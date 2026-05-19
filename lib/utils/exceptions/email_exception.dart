import '../../ui/core/localization/applocalization.dart';

class EmailException implements Exception {
  final LocalizationKey messageKey;
  EmailException(this.messageKey);

  @override
  String toString() => messageKey.name;
}