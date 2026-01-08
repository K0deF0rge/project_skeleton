import 'package:flutter/material.dart';

import '../core/logger.dart';
import '../ui/auth/reset_password/widgets/reset_password_screen.dart';
import '../ui/auth/onboarding/widgets/onboarding_screen.dart';
import '../ui/auth/signin/widgets/signin_screen.dart';
import '../ui/auth/signup/widgets/signup_screen.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/users/widgets/users_screen.dart';

class Routing {
  static Map<String, Widget Function(RouteSettings)> routeToWidgetMappings = {
    SigninScreen.routeName: (settings) => const SigninScreen(),
    SignupScreen.routeName: (settings) => const SignupScreen(),
    OnboardingScreen.routeName: (settings) => const OnboardingScreen(),
    ResetPasswordScreen.routeName: (settings) => const ResetPasswordScreen(),
    HomeScreen.routeName: (settings) => const HomeScreen(),
    UsersScreen.routeName: (settings) => const UsersScreen(),
  };

  static Widget getWidgetOfRoute(RouteSettings settings) {
    final routeName = settings.name ?? HomeScreen.routeName;
    AppLogger.debug("ROUTING getWidgetOfRoute: routeName $routeName ROUTING");

    final widgetFunction = routeName.contains('?code=')
        ? routeToWidgetMappings[HomeScreen.routeName]
        : routeToWidgetMappings[routeName];

    assert(widgetFunction != null, "Error! route not found.");
    return widgetFunction!(settings);
  }

  static PageRoute onGenerateRoute(RouteSettings settings) {
    AppLogger.debug("ROUTING onGenerateRoute: settings $settings ROUTING");
    return MaterialPageRoute(
      builder: (context) => getWidgetOfRoute(settings),
      settings: settings,
    );
  }
}
