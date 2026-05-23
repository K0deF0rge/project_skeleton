import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum LocalizationKey {
  exit,
  retryButton,

  // Enum Modules
  moduleUsers,
  moduleProducts,

  // Enum User Role
  userRoleOwner,
  userRoleAdmin,
  userRoleUser,

  homeMenuTitle,

  // SignIn Screen
  signInTitle,
  signInSubtitle,
  emailLabel,
  passwordLabel,
  signInButtonLabel,
  signInLoadingLabel,
  forgotPasswordButton,
  signUpButton,

  // SignUp Screen
  signUpTitle,
  confirmPasswordLabel,
  signUpButtonLabel,
  signUpLoadingLabel,
  passwordMismatchError,

  // Reset Password Screen
  resetPasswordTitle,
  resetPasswordSubtitle,
  resetPasswordButtonLabel,
  resetPasswordLoadingLabel,

  // Users Screen
  usersTitle,
  usersEmptyState,

  // Email Validator Messages
  emailEmptyError,
  emailInvalidError,
  emailValidSuccess,
  // Password Validator Messages
  passwordEmptyError,
  passwordShortError,
  passwordNoUpperCaseError,
  passwordNoLowerCaseError,
  passwordNoNumberError,
  passwordNoSpecialCharError,
  passwordValidSuccess,

  // Events
  magicLinkSent,
  signInSuccess,
  signUpSuccess,
  resetPasswordSuccess,
  getUserSuccess,

  unknownError,
}

enum AppLanguage { pt, en }

class AppLocalization {
  final AppLanguage language;

  AppLocalization(this.language);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const Map<AppLanguage, Map<LocalizationKey, String>> _strings = {
    AppLanguage.pt: {
      LocalizationKey.exit: 'Sair',
      LocalizationKey.retryButton: 'Tentar novamente',
      LocalizationKey.moduleUsers: 'Usuários',
      LocalizationKey.moduleProducts: 'Produtos',
      LocalizationKey.userRoleOwner: 'Proprietário',
      LocalizationKey.userRoleAdmin: 'Administrador',
      LocalizationKey.userRoleUser: 'Usuário',
      LocalizationKey.homeMenuTitle: 'Configurações',
      LocalizationKey.signInTitle: 'Login',
      LocalizationKey.signInSubtitle: 'Entre utilizando E-mail e Senha.',
      LocalizationKey.emailLabel: 'E-mail',
      LocalizationKey.passwordLabel: 'Senha',
      LocalizationKey.signInButtonLabel: 'Entrar',
      LocalizationKey.signInLoadingLabel: 'Entrando...',
      LocalizationKey.forgotPasswordButton: 'Redefinir a senha',
      LocalizationKey.signUpButton: 'Cadastrar-se',
      LocalizationKey.signUpTitle: 'Cadastro',
      LocalizationKey.confirmPasswordLabel: 'Confirme a Senha',
      LocalizationKey.signUpButtonLabel: 'Cadastrar-se',
      LocalizationKey.signUpLoadingLabel: 'Cadastrando...',
      LocalizationKey.passwordMismatchError: 'As senhas não coincidem',
      LocalizationKey.resetPasswordTitle: 'Redefinir a senha',
      LocalizationKey.resetPasswordSubtitle: 'Digite seu e-mail para receber instruções de redefinição.',
      LocalizationKey.resetPasswordButtonLabel: 'Enviar e-mail',
      LocalizationKey.resetPasswordLoadingLabel: 'Enviando...',
      LocalizationKey.usersTitle: 'Usuários',
      LocalizationKey.usersEmptyState: 'Sem usuários',
      LocalizationKey.emailEmptyError: 'O email não pode estar vazio',
      LocalizationKey.emailInvalidError: 'Por favor, insira um email válido',
      LocalizationKey.emailValidSuccess:
          'Verifique seu email para usar o magic link!',
      LocalizationKey.passwordEmptyError: 'Digite uma senha',
      LocalizationKey.passwordShortError:
          'A senha deve ter no mínimo 8 caracteres',
      LocalizationKey.passwordNoUpperCaseError:
          'A senha deve conter pelo menos uma letra maiúscula',
      LocalizationKey.passwordNoLowerCaseError:
          'A senha deve conter pelo menos uma letra minúscula',
      LocalizationKey.passwordNoNumberError:
          'A senha deve conter pelo menos um número',
      LocalizationKey.passwordNoSpecialCharError:
          'A senha deve conter pelo menos um caractere especial (!@#\$%^&*)',
      LocalizationKey.passwordValidSuccess: 'Senha válida',
      LocalizationKey.magicLinkSent: 'O link mágico foi enviado para {email}',
      LocalizationKey.signInSuccess: 'Login realizado com sucesso',
      LocalizationKey.signUpSuccess: 'Cadastro realizado com sucesso! Valide o seu e-mail antes de fazer login.',
      LocalizationKey.resetPasswordSuccess: 'E-mail de redefinição enviado! Verifique sua caixa de entrada.',
      LocalizationKey.getUserSuccess: 'Usuário encontrado com sucesso',
      LocalizationKey.unknownError: 'Ocorreu um erro desconhecido',
    },
    AppLanguage.en: {
      LocalizationKey.exit: 'Exit',
      LocalizationKey.retryButton: 'Try Again',
      LocalizationKey.moduleUsers: 'Users',
      LocalizationKey.moduleProducts: 'Products',
      LocalizationKey.userRoleOwner: 'Owner',
      LocalizationKey.userRoleAdmin: 'Administrator',
      LocalizationKey.userRoleUser: 'User',
      LocalizationKey.homeMenuTitle: 'Settings',
      LocalizationKey.signInTitle: 'Login',
      LocalizationKey.signInSubtitle: 'Sign in using Email and Password.',
      LocalizationKey.emailLabel: 'Email',
      LocalizationKey.passwordLabel: 'Password',
      LocalizationKey.signInButtonLabel: 'Sign In',
      LocalizationKey.signInLoadingLabel: 'Signing in...',
      LocalizationKey.forgotPasswordButton: 'Forgot Password',
      LocalizationKey.signUpButton: 'Sign Up',
      LocalizationKey.signUpTitle: 'Sign Up',
      LocalizationKey.confirmPasswordLabel: 'Confirm Password',
      LocalizationKey.signUpButtonLabel: 'Sign Up',
      LocalizationKey.signUpLoadingLabel: 'Signing up...',
      LocalizationKey.passwordMismatchError: 'Passwords do not match',
      LocalizationKey.resetPasswordTitle: 'Reset Password',
      LocalizationKey.resetPasswordSubtitle: 'Enter your email to receive password reset instructions.',
      LocalizationKey.resetPasswordButtonLabel: 'Send Email',
      LocalizationKey.resetPasswordLoadingLabel: 'Sending...',
      LocalizationKey.usersTitle: 'Users',
      LocalizationKey.usersEmptyState: 'No users',
      LocalizationKey.emailEmptyError: 'Email cannot be empty',
      LocalizationKey.emailInvalidError: 'Please enter a valid email address',
      LocalizationKey.emailValidSuccess:
          'Check your email to use the magic link!',
      LocalizationKey.passwordEmptyError: 'Please enter a password',
      LocalizationKey.passwordShortError:
          'The password must be at least 8 characters long',
      LocalizationKey.passwordNoUpperCaseError:
          'The password must contain at least one uppercase letter',
      LocalizationKey.passwordNoLowerCaseError:
          'The password must contain at least one lowercase letter',
      LocalizationKey.passwordNoNumberError:
          'The password must contain at least one number',
      LocalizationKey.passwordNoSpecialCharError:
          'The password must contain at least one special character (!@#\$%^&*)',
      LocalizationKey.passwordValidSuccess: 'Valid password',
      LocalizationKey.magicLinkSent: 'The magic link has been sent to {email}',
      LocalizationKey.signInSuccess: 'Login successful',
      LocalizationKey.signUpSuccess: 'Sign up successful! Please verify your email before logging in.',      
      LocalizationKey.resetPasswordSuccess: 'Password reset email sent! Check your inbox.',
      LocalizationKey.getUserSuccess: 'User found successfully',
      LocalizationKey.unknownError: 'An unknown error occurred',
    },
  };

  String _get(LocalizationKey key) {
    return _strings[language]?[key] ?? '[${key.name.toUpperCase()}]';
  }

  String get exit => _get(LocalizationKey.exit);

  String get moduleUsers => _get(LocalizationKey.moduleUsers);

  String get moduleProducts => _get(LocalizationKey.moduleProducts);

  String get userRoleOwner => _get(LocalizationKey.userRoleOwner);

  String get userRoleAdmin => _get(LocalizationKey.userRoleAdmin);

  String get userRoleUser => _get(LocalizationKey.userRoleUser);

  String get homeMenuTitle => _get(LocalizationKey.homeMenuTitle);

  String get signInTitle => _get(LocalizationKey.signInTitle);

  String get signInSubtitle => _get(LocalizationKey.signInSubtitle);

  String get emailLabel => _get(LocalizationKey.emailLabel);

  String get passwordLabel => _get(LocalizationKey.passwordLabel);

  String get signInButtonLabel => _get(LocalizationKey.signInButtonLabel);

  String get signInLoadingLabel => _get(LocalizationKey.signInLoadingLabel);

  String get forgotPasswordButton => _get(LocalizationKey.forgotPasswordButton);

  String get signUpButton => _get(LocalizationKey.signUpButton);

  String get signUpTitle => _get(LocalizationKey.signUpTitle);

  String get confirmPasswordLabel => _get(LocalizationKey.confirmPasswordLabel);

  String get signUpButtonLabel => _get(LocalizationKey.signUpButtonLabel);

  String get signUpLoadingLabel => _get(LocalizationKey.signUpLoadingLabel);

  String get passwordMismatchError => _get(LocalizationKey.passwordMismatchError);

  String get resetPasswordTitle => _get(LocalizationKey.resetPasswordTitle);

  String get resetPasswordSubtitle => _get(LocalizationKey.resetPasswordSubtitle);

  String get resetPasswordButtonLabel => _get(LocalizationKey.resetPasswordButtonLabel);

  String get resetPasswordLoadingLabel => _get(LocalizationKey.resetPasswordLoadingLabel);

  String get usersTitle => _get(LocalizationKey.usersTitle);

  String get usersEmptyState => _get(LocalizationKey.usersEmptyState);

  String get retryButton => _get(LocalizationKey.retryButton);

  String get emailEmptyError => _get(LocalizationKey.emailEmptyError);

  String get emailInvalidError => _get(LocalizationKey.emailInvalidError);

  String get emailValidSuccess => _get(LocalizationKey.emailValidSuccess);

  String get passwordEmptyError => _get(LocalizationKey.passwordEmptyError);

  String get passwordShortError => _get(LocalizationKey.passwordShortError);

  String get passwordNoUpperCaseError =>
      _get(LocalizationKey.passwordNoUpperCaseError);

  String get passwordNoLowerCaseError =>
      _get(LocalizationKey.passwordNoLowerCaseError);

  String get passwordNoNumberError =>
      _get(LocalizationKey.passwordNoNumberError);

  String get passwordNoSpecialCharError =>
      _get(LocalizationKey.passwordNoSpecialCharError);

  String get passwordValidSuccess => _get(LocalizationKey.passwordValidSuccess);

  String magicLinkSent(String email) =>
      _get(LocalizationKey.magicLinkSent).replaceAll('{email}', email);

  String get signInSuccess => _get(LocalizationKey.signInSuccess);

  String get signUpSuccess => _get(LocalizationKey.signUpSuccess);      

  String get resetPasswordSuccess => _get(LocalizationKey.resetPasswordSuccess);

  String get getUserSuccess => _get(LocalizationKey.getUserSuccess);

  String get unknownError => _get(LocalizationKey.unknownError);

  String getTextByKey(LocalizationKey key) => _get(key);
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  @override
  bool isSupported(Locale locale) => ['pt', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    final language = locale.languageCode == 'pt'
        ? AppLanguage.pt
        : AppLanguage.en;

    return SynchronousFuture(AppLocalization(language));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}
