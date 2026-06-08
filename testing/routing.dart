import 'package:flutter/material.dart';
import 'package:project_skeleton/ui/auth/onboarding/widgets/onboarding_screen.dart';
import 'package:project_skeleton/ui/auth/reset_password/widgets/reset_password_screen.dart';
import 'package:project_skeleton/ui/auth/signin/widgets/signin_screen.dart';
import 'package:project_skeleton/ui/auth/signup/widgets/signup_screen.dart';
import 'package:project_skeleton/ui/home/widgets/home_screen.dart';
import 'package:project_skeleton/ui/users/widgets/users_screen.dart';

class RoutingTest {
  static Map<String, Widget Function(RouteSettings)> routeToWidgetMappings = {
    SigninScreen.routeName: (settings) => Placeholder(key: Key(SigninScreen.routeName)),
    SignupScreen.routeName: (settings) => Placeholder(key: Key(SignupScreen.routeName)),
    OnboardingScreen.routeName: (settings) => Placeholder(key: Key(OnboardingScreen.routeName)),
    ResetPasswordScreen.routeName: (settings) => Placeholder(key: Key(ResetPasswordScreen.routeName)),
    HomeScreen.routeName: (settings) => Placeholder(key: Key(HomeScreen.routeName)),
    UsersScreen.routeName: (settings) => Placeholder(key: Key(UsersScreen.routeName)),
  };

  static Widget getWidgetOfRoute(RouteSettings settings) {
    final routeName = settings.name ?? HomeScreen.routeName;

    final widgetFunction = routeName.contains('?code=')
        ? routeToWidgetMappings[HomeScreen.routeName]
        : routeToWidgetMappings[routeName];

    assert(widgetFunction != null, "Error! route not found.");
    return widgetFunction!(settings);
  }

  static PageRoute onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => getWidgetOfRoute(settings),
      settings: settings,
    );
  }
}
