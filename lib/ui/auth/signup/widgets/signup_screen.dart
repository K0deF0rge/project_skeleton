import '../../../../config/constants.dart';
import '../../../../core/logger.dart';
import '../../../../utils/extensions/context.dart';
import '../../../../utils/result.dart';
import '../../../../utils/validators/email_validator.dart';
import '../../../../utils/validators/password_validator.dart';
import '../../../../data/repositories/auth/auth_repository_provider.dart';
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
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late SignupViewmodel _viewmodel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.viewmodel != null) {
      _viewmodel = widget.viewmodel!;
    } else {
      final authRepository = AuthRepositoryProvider.of(context);
      _viewmodel = SignupViewmodel(authRepository: authRepository);
    }
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    await _viewmodel.signup.execute(email, password);

    if (!mounted) return;

    context.showSnackBar(
      _viewmodel.signup.error
          ? (_viewmodel.signup.result as Error).error.toString()
          : (_viewmodel.signup.result as Ok<String>).value,
      isError: _viewmodel.signup.error,
    );

    if (_viewmodel.signup.result is Ok<String>) {
      Navigator.of(context).pop();
    }
  }

  String? _validatePasswordMatch(String? value) {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    if (password != confirmPassword) {
      return 'As senhas não coincidem.';
    }
    return null;
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.debug('Building SignupScreen');
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar-se')),
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
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: EmailValidator.validator,
              ),
              colDividerMedium,
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: PasswordValidator.validator,
              ),
              colDividerMedium,
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirme a Senha',
                ),
                obscureText: true,
                validator: _validatePasswordMatch,
              ),
              colDividerLarge2,

              ListenableBuilder(
                listenable: _viewmodel.signup,
                builder: (context, _) {
                  return ElevatedButton(
                    onPressed: _viewmodel.signup.running ? null : _register,
                    child: Text(
                      _viewmodel.signup.running
                          ? 'Cadastrando...'
                          : 'Cadastrar-se',
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
