import '../../../../config/constants.dart';
import '../../../../core/logger.dart';
import '../../../../data/repositories/auth/auth_repository_provider.dart';
import '../../../../utils/extensions/context.dart';
import '../../../../utils/result.dart';
import '../../reset_password/widgets/reset_password_screen.dart';
import '../../signup/widgets/signup_screen.dart';
import '../view_models/signin_viewmodel.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  static String routeName = "/signin";

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late SigninViewmodel viewmodel;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AuthRepository authRepository;

  void _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    viewmodel.signin.execute(email, password);
  }

  bool _viewmodelInitialized = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_viewmodelInitialized) {
      authRepository = AuthRepositoryProvider.of(context);
      viewmodel = SigninViewmodel(authRepository: authRepository);
      viewmodel.signin.addListener(_onResult);
      _viewmodelInitialized = true;
    }
  }

  @override
  void dispose() {
    viewmodel.signin.removeListener(_onResult);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.debug('BUILDING (SigninScreen) BUILDING');

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: mediumSpacing,
          horizontal: largeSpacing,
        ),
        child: Column(
          children: [
            colDividerLarge2,
            Text(
              'Entre utilizando E-mail e Senha.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            colDividerLarge2,
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            colDividerMedium,
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            colDividerLarge2,
            ListenableBuilder(
              listenable: viewmodel.signin,
              builder: (context, _) {
                return ElevatedButton(
                  onPressed: _signIn,
                  child: Text(
                    viewmodel.signin.running ? 'Entrando...' : 'Entrar',
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
                  child: const Text('Redefinir a senha'),
                ),
                colDividerSmall,
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    SignupScreen.routeName,
                  ),
                  child: const Text('Cadastrar-se'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onResult() {
    if (!mounted) return;
    AppLogger.debug("_onResult ${viewmodel.signin.result}");
    if (viewmodel.signin.result == null) return;
    context.showSnackBar(
      viewmodel.signin.completed
          ? (viewmodel.signin.result! as Ok<String>).value
          : (viewmodel.signin.result as Error).error.toString(),
      isError: viewmodel.signin.error,
    );
    // viewmodel.signin.clearResult();
  }
}
