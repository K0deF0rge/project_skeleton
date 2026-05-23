import '../../../../config/constants.dart';
import '../../../../data/models/credentials.dart';
import '../../../../data/repositories/role/user_repository_provider.dart';
import '../../../../data/repositories/user/user_repository_provider.dart';
import '../../../../domain/use_cases/auth/auth_sign_up_use_case.dart';
import '../../../../utils/exceptions/credentials_exception.dart';
import '../../../../utils/extensions/context.dart';
import '../../../../utils/result.dart';
import '../../../../utils/validators/email_validator.dart';
import '../../../../utils/validators/password_validator.dart';
import '../../../../data/repositories/auth/auth_repository_provider.dart';
import '../../../core/localization/applocalization.dart';
import '../../../home/widgets/home_screen.dart';
import '../view_models/signup_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, this.viewmodel});
  final SignupViewmodel? viewmodel;
  static String routeName = "/signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late SignupViewmodel viewmodel;
  late AppLocalization localization;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.viewmodel != null) {
      viewmodel = widget.viewmodel!;
    } else {
      viewmodel = SignupViewmodel(
        signUpUseCase: AuthSignUpUseCase(
          authRepository: AuthRepositoryProvider.of(context),
          roleRepository: RoleRepositoryProvider.of(context),
          userRepository: UserRepositoryProvider.of(context),
        ),
      );
    }
    viewmodel.signup.addListener(onResult);
  }

  @override
  void dispose() {
    viewmodel.signup.removeListener(onResult);
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    localization = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localization.signUpTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: mediumSpacing,
              horizontal: largeSpacing,
            ),
            child: Column(
              children: [
                colDividerLarge2,
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: localization.emailLabel),
                  validator: (String? email) {
                    LocalizationKey? validationKey = EmailValidator.validator(
                      email,
                    );

                    if (validationKey != null) {
                      return localization.getTextByKey(validationKey);
                    }

                    return null;
                  },
                ),
                colDividerMedium,
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: localization.passwordLabel,
                  ),
                  obscureText: true,
                  validator: (String? password) {
                    LocalizationKey? validationKey = PasswordValidator.validator(
                      password,
                    );

                    if (validationKey != null) {
                      return localization.getTextByKey(validationKey);
                    }

                    return null;
                  },
                ),
                colDividerMedium,
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: localization.confirmPasswordLabel,
                  ),
                  obscureText: true,
                  validator: validatePasswordMatch,
                ),
                colDividerLarge2,
                ListenableBuilder(
                  listenable: viewmodel.signup,
                  builder: (context, _) {
                    return ElevatedButton(
                      onPressed: viewmodel.signup.running ? null : register,
                      child: Text(
                        viewmodel.signup.running
                            ? localization.signUpLoadingLabel
                            : localization.signUpButtonLabel,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onResult() {
    if (!mounted) return;

    if (viewmodel.signup.result == null) return;

    LocalizationKey locKey;

    if (viewmodel.signup.completed) {
      locKey = LocalizationKey.signUpSuccess;
      viewmodel.signup.clearResult();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      final error = (viewmodel.signup.result as Error).error;

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
      isError: viewmodel.signup.error,
    );
  }

  void register() {
    if (!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    viewmodel.signup.execute(Credentials(email: email, password: password));
  }

  String? validatePasswordMatch(String? value) {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    if (password != confirmPassword) {
      return localization.passwordMismatchError;
    }
    return null;
  }
}
