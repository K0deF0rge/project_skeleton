import '../../../../config/constants.dart';
import '../../../../core/logger.dart';
import '../../../../utils/extensions/context.dart';
import '../../../../utils/result.dart';
import '../../../../utils/validators/email_validator.dart';
import '../../../../data/repositories/auth/auth_repository_provider.dart';
import '../view_models/reset_password_viewmodel.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, this.viewmodel});
  final ResetPasswordViewmodel? viewmodel;
  static String routeName = "/reset-password";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late ResetPasswordViewmodel _viewmodel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.viewmodel != null) {
      _viewmodel = widget.viewmodel!;
    } else {
      final authRepository = AuthRepositoryProvider.of(context);
      _viewmodel = ResetPasswordViewmodel(authRepository: authRepository);
    }
  }

  void _sendReset() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    await _viewmodel.reset.execute(email);

    if (!mounted) return;

    if (_viewmodel.reset.error) {
      context.showSnackBar(
        'Erro ao enviar e-mail: ${(_viewmodel.reset.result as Error).error}',
        isError: true,
      );
      return;
    } else {
      context.showSnackBar(( _viewmodel.reset.result as Ok<String>).value);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.debug('Building ResetPasswordScreen');
    return Scaffold(
      appBar: AppBar(title: const Text('Redefinir a senha')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: mediumSpacing,
            horizontal: largeSpacing,
          ),
          child: Column(
            children: [
              colDividerLarge2,
              Text(
                'Digite seu e-mail para receber instruções de redefinição.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              colDividerMedium,
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: EmailValidator.validator,
              ),
              colDividerLarge2,
              ListenableBuilder(
                listenable: _viewmodel.reset,
                builder: (context, _) {
                  return ElevatedButton(
                    onPressed: _viewmodel.reset.running
                        ? null
                        : _sendReset,
                    child: Text(
                      _viewmodel.reset.running
                          ? 'Enviando...'
                          : 'Enviar e-mail',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
