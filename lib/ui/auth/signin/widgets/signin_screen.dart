import '../../../../config/constants.dart';
import '../../../../data/repositories/auth/auth_repository_provider.dart';
import '../../../../data/repositories/role/user_repository_provider.dart';
import '../../../../data/repositories/user/user_repository_provider.dart';
import '../../../../domain/use_cases/auth/auth_sign_in_use_case.dart';
import '../../../../utils/extensions/context.dart';
import '../../../../utils/result.dart';
import '../../../../utils/validators/credentials_validator.dart';
import '../../../core/localization/applocalization.dart';
import '../../../home/widgets/home_screen.dart';
import '../../reset_password/widgets/reset_password_screen.dart';
import '../../signup/widgets/signup_screen.dart';
import '../view_models/signin_viewmodel.dart';

class SigninScreen extends StatefulWidget {
  static String routeName = "/signin";

  const SigninScreen({super.key, this.viewmodel});
  final SigninViewmodel? viewmodel;

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late SigninViewmodel viewmodel;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late AppLocalization localization;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.viewmodel != null) {
      viewmodel = widget.viewmodel!;
    } else {
      viewmodel = SigninViewmodel(
        signInUseCase: AuthSignInUseCase(
          authRepository: AuthRepositoryProvider.of(context),
          userRepository: UserRepositoryProvider.of(context),
          roleRepository: RoleRepositoryProvider.of(context),
        ),
      );
    }
    viewmodel.signin.addListener(onResult);
  }

  @override
  void dispose() {
    viewmodel.signin.removeListener(onResult);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    localization = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localization.signInTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: mediumSpacing,
            horizontal: largeSpacing,
          ),
          child: Column(
            children: [
              colDividerLarge2,
              Text(
                localization.signInSubtitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              colDividerLarge2,
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: localization.emailLabel),
              ),
              colDividerMedium,
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: localization.passwordLabel,
                ),
                obscureText: true,
              ),
              colDividerLarge2,
              ListenableBuilder(
                listenable: viewmodel.signin,
                builder: (context, _) {
                  return ElevatedButton(
                    onPressed: signIn,
                    child: Text(
                      viewmodel.signin.running
                          ? localization.signInLoadingLabel
                          : localization.signInButtonLabel,
                    ),
                  );
                },
              ),
              colDividerSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      ResetPasswordScreen.routeName,
                    ),
                    child: Text(localization.forgotPasswordButton),
                  ),
                  colDividerSmall,
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignupScreen.routeName),
                    child: Text(localization.signUpButton),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onResult() {
    if (!mounted) return;

    if (viewmodel.signin.result == null) return;

    LocalizationKey locKey;

    if (viewmodel.signin.completed) {
      locKey = LocalizationKey.signInSuccess;
      viewmodel.signin.clearResult();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      final error = (viewmodel.signin.result as Error).error;

      switch (error) {
        case CredentialsException(:final localizationKey):
          locKey = localizationKey;
          break;
        default:
          locKey = LocalizationKey.unknownError;
          break;
      }
    }

    context.showSnackBar(
      localization.getTextByKey(locKey),
      isError: viewmodel.signin.error,
    );
  }

  void signIn() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    viewmodel.signin.execute(Credentials(email: email, password: password));
  }
}
