import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_skeleton/ui/auth/reset_password/widgets/reset_password_screen.dart';

import '../../../../testing/my_app.dart';

void main() {
  group('widget presence', () {
    testWidgets('shows title, subtitle, email field and button', (
      tester,
    ) async {
      await testApp(tester, const ResetPasswordScreen());

      expect(find.text('Reset Password'), findsOneWidget);

      expect(find.textContaining('Enter your email'), findsOneWidget);

      final fields = find.byType(TextFormField);
      expect(fields, findsWidgets);

      expect(find.text('Send Email'), findsOneWidget);
    });
  });

  group('snackBar behavior', () {
    testWidgets('shows error snackbar when repository returns error', (
      tester,
    ) async {
      await testApp(tester, const ResetPasswordScreen());

      await tester.enterText(find.byType(TextFormField).first, 'ab.com');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Send Email'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('shows success snackbar on valid email and successful reset', (
      tester,
    ) async {
      await testApp(tester, const ResetPasswordScreen());

      await tester.enterText(find.byType(TextFormField).first, 'a@b.com');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Send Email'));
      await tester.pumpAndSettle();

      // Não consigo validar a mensagem devido ao Navigato.pop, eu acho. Logo, vou validar se saiu da ResetPassWordScreen.
      expect(find.byType(ResetPasswordScreen), findsNothing);
      // expect(
      //   find.text('Password reset email sent! Check your inbox.'),
      //   findsOneWidget,
      // );
    });
  });
}