import '../../../../config/constants.dart';
import '../../../../domain/use_cases/auth/auth_reset_password_use_case.dart';
import '../../../../utils/exceptions/email_exception.dart';
import '../../../../utils/extensions/context.dart';
import '../../../../utils/result.dart';
import '../../../../utils/validators/email_validator.dart';
import '../../../../data/repositories/auth/auth_repository_provider.dart';
import '../../../core/localization/applocalization.dart';
import '../view_models/reset_password_viewmodel.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, this.viewmodel});
  final ResetPasswordViewmodel? viewmodel;
  static String routeName = "/reset-password";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late ResetPasswordViewmodel viewmodel;
  late AppLocalization localization;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.viewmodel != null) {
      viewmodel = widget.viewmodel!;
    } else {
      viewmodel = ResetPasswordViewmodel(
        resetPasswordUseCase: AuthResetPasswordUseCase(
          authRepository: AuthRepositoryProvider.of(context),
        ),
      );
    }
    viewmodel.resetPassword.addListener(onResult);
  }

  @override
  void dispose() {
    viewmodel.resetPassword.removeListener(onResult);
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    localization = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localization.resetPasswordTitle)),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: mediumSpacing,
              horizontal: largeSpacing,
            ),
            child: Column(
              children: [
                colDividerLarge2,
                Text(
                  localization.resetPasswordSubtitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                colDividerMedium,
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
                colDividerLarge2,
                ListenableBuilder(
                  listenable: viewmodel.resetPassword,
                  builder: (context, _) {
                    return ElevatedButton(
                      onPressed: viewmodel.resetPassword.running ? null : reset,
                      child: Text(
                        viewmodel.resetPassword.running
                            ? localization.resetPasswordLoadingLabel
                            : localization.resetPasswordButtonLabel,
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

    if (viewmodel.resetPassword.result == null) return;

    LocalizationKey locKey;

    if (viewmodel.resetPassword.completed) {
      locKey = LocalizationKey.resetPasswordSuccess;
      viewmodel.resetPassword.clearResult();
      Navigator.pop(context);
    } else {
      final error =
          (viewmodel.resetPassword.result as Error<LocalizationKey>).error;

      switch (error) {
        case EmailException(:final localizationKey):
          locKey = localizationKey;
          break;
        default:
          locKey = LocalizationKey.unknownError;
          break;
      }
    }

    context.showSnackBar(
      localization.getTextByKey(locKey),
      isError: viewmodel.resetPassword.error,
    );
  }

  void reset() {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    viewmodel.resetPassword.execute(email);
  }
}
