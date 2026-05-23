import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/models/user_state.dart';
import 'data/repositories/auth/auth_repository_provider.dart';
import 'data/repositories/role/user_repository_provider.dart';
import 'data/repositories/user/user_repository_provider.dart';
import 'routing/routing.dart';
import 'ui/auth/signin/widgets/signin_screen.dart';
import 'ui/auth/splash/widgets/splash_screen.dart';
import 'ui/core/localization/applocalization.dart';
import 'ui/core/themes/theme.dart';
import 'ui/home/widgets/home_screen.dart';
import 'utils/extensions/context.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.authRepository,
    required this.userRepository,
    required this.roleRepository,
  });
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final RoleRepository roleRepository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _authListenerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_authListenerInitialized) {
      widget.authRepository.addAuthStateListener(_onAuthStateChange);
      _authListenerInitialized = true;
    }
  }

  @override
  void dispose() {
    widget.authRepository.removeAuthStateListener(_onAuthStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthRepositoryProvider(
      authRepository: widget.authRepository,
      child: UserRepositoryProvider(
        userRepository: widget.userRepository,
        child: RoleRepositoryProvider(
          roleRepository: widget.roleRepository,
          child: MaterialApp(
            title: 'Title',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            themeAnimationCurve: Curves.ease,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            localizationsDelegates: [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              AppLocalizationDelegate(),
            ],
            home: SafeArea(
              child: ValueListenableBuilder<UserState>(
                valueListenable: widget.authRepository.userState,
                builder: (context, state, _) {
                  if (state is UserLoading) return const SplashScreen();
                  if (state is UserLogged) return const HomeScreen();
                  return const SigninScreen();
                },
              ),
            ),
            onGenerateRoute: Routing.onGenerateRoute,
          ),
        ),
      ),
    );
  }

  void _onAuthStateChange() {
    final result = widget.authRepository.onDataAuthStateChange.result;
    if (result is Error) {
      // context.showSnackBar('ERRO: ${(result as Error).error}', isError: true);
      // _authRepository.onDataAuthStateChange.clearResult();
    }
  }
}
