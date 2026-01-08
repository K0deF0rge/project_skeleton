import '../exceptions/email_exception.dart';

enum ResultEmailValidator {
  emptyEmail('Digite um e-mail'),
  invalidEmail('Digite um e-mail válido'),
  validEmail('Confira o seu e-mail para utilizar o link mágico!');
  
  final String text;
  const ResultEmailValidator(this.text);
}

class EmailValidator {
  static EmailException? validate(String? email) {
    if (email == null || email == '') return EmailException(ResultEmailValidator.emptyEmail.text);

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );

    if (!emailRegex.hasMatch(email)) return EmailException(ResultEmailValidator.invalidEmail.text);
    return null;
  }

  static String? validator(String? email) {
    if (email == null || email == '') return ResultEmailValidator.emptyEmail.text;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );

    if (!emailRegex.hasMatch(email)) return ResultEmailValidator.invalidEmail.text;
    return null;
  }
}
