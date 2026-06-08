import 'package:project_skeleton/data/repositories/auth/auth_repository_dev.dart';
import 'package:project_skeleton/data/repositories/auth/auth_repository_provider.dart';
import 'package:project_skeleton/data/repositories/role/role_repository_dev.dart';
import 'package:project_skeleton/data/repositories/role/user_repository_provider.dart';
import 'package:project_skeleton/data/repositories/user/user_repository_dev.dart';
import 'package:project_skeleton/data/repositories/user/user_repository_provider.dart';
import 'package:project_skeleton/ui/core/localization/applocalization.dart';
import 'package:project_skeleton/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'routing.dart';

Future<void> testApp(
  WidgetTester tester,
  Widget body, {
  String localeLanguage = 'en',
  String localeCountry = 'US',
}) async {
  tester.view.devicePixelRatio = 1.0;
  await tester.binding.setSurfaceSize(const Size(1200, 800));
  await tester.binding.setLocale(localeLanguage, localeCountry);
  await mockNetworkImages(() async {
    await tester.pumpWidget(
      AuthRepositoryProvider(
        authRepository: AuthRepositoryDev(),
        child: UserRepositoryProvider(
          userRepository: UserRepositoryDev(service: null),
          child: RoleRepositoryProvider(
            roleRepository: RoleRepositoryDev(),
            child: MaterialApp(
              localizationsDelegates: [
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                AppLocalizationDelegate(),
              ],
              theme: AppTheme.light,
              home: body,
              onGenerateRoute: RoutingTest.onGenerateRoute,
            ),
          ),
        ),
      ),
    );
  });
}