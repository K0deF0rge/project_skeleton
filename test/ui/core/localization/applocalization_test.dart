import 'package:flutter_test/flutter_test.dart';
import 'package:project_skeleton/ui/core/localization/applocalization.dart';

void main() {
  test('returns Portuguese strings correctly', () {
    final loc = AppLocalization(AppLanguage.pt);
    expect(loc.signInTitle, 'Login');
    expect(loc.emailLabel, 'E-mail');
    expect(loc.passwordLabel, 'Senha');
    expect(loc.magicLinkSent('a@b.com'), contains('a@b.com'));
  });

  test('returns English strings correctly', () {
    final loc = AppLocalization(AppLanguage.en);
    expect(loc.signInTitle, 'Login');
    expect(loc.emailLabel, 'Email');
    expect(loc.passwordLabel, 'Password');
    expect(loc.magicLinkSent('x@y.com'), contains('x@y.com'));
  });

  test('fallback returns bracketed key for missing entries', () {
    final loc = AppLocalization(AppLanguage.en);
    expect(loc.getTextByKey(LocalizationKey.unknownError), isNotEmpty);
  });
}
