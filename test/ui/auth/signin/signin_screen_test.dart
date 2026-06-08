import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_skeleton/ui/auth/signin/widgets/signin_screen.dart';
import 'package:project_skeleton/ui/home/widgets/home_screen.dart';

import '../../../../testing/my_app.dart';

void main() {
  group('widget presence', () {
    testWidgets('renders title, fields and buttons', (tester) async {
      await testApp(tester, const SigninScreen());

      expect(find.text('Login'), findsOneWidget);

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Forgot Password'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });
  });

  group('snackBar behavior', () {
    testWidgets('shows validation error for invalid email', (tester) async {
      await testApp(tester, const SigninScreen());

      await tester.enterText(find.byType(TextFormField).first, 'ab.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('navigates to home on successful sign in', (tester) async {
      await testApp(tester, const SigninScreen());

      await tester.enterText(find.byType(TextFormField).first, 'dev@gmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'StrongPass1@');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.byKey(Key(HomeScreen.routeName)), findsOneWidget);
    });
  });
}
