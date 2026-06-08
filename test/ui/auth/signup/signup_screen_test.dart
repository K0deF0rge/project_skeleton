import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_skeleton/ui/auth/signup/widgets/signup_screen.dart';
import 'package:project_skeleton/ui/home/widgets/home_screen.dart';

import '../../../../testing/my_app.dart';

void main() {
  group('widget presence', () {
    testWidgets('shows appbar, fields and sign up button', (tester) async {
      await testApp(tester, const SignupScreen());

      expect(find.text('Sign Up'), findsWidgets);

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);

      final fields = find.byType(TextFormField);
      expect(fields, findsWidgets);
    });
  });

  group('snackBar behavior', () {
    testWidgets('shows validation error on password mismatch', (tester) async {
      await testApp(tester, const SignupScreen());

      await tester.enterText(find.byType(TextFormField).at(0), 'a@b.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password1');
      await tester.enterText(find.byType(TextFormField).at(2), 'password2');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('navigates to home on successful sign up', (tester) async {
      await testApp(tester, const SignupScreen());

      await tester.enterText(find.byType(TextFormField).at(0), 'dev@gmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'StrongPass1!');
      await tester.enterText(find.byType(TextFormField).at(2), 'StrongPass1!');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byKey(Key(HomeScreen.routeName)), findsOneWidget);
    });
  });
}
