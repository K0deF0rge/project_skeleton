import 'package:project_skeleton/data/models/credentials.dart';

final kValidCredentials = Credentials(
  email: 'test@example.com',
  password: 'Abc1234!',
);

final kInvalidEmails = [
  Credentials(
    email: '',
    password: 'Abc1234!',
  ), // empty email
  Credentials(
    email: 'testeexample.com',
    password: 'Abc1234!',
  ), // missing @
  Credentials(
    email: 'teste@examplecom',
    password: 'Abc1234!',
  ), // missing dot
  Credentials(
    email: 'teste@example.',
    password: 'Abc1234!',
  ), // incomplete TLD
  Credentials(
    email: '@example.com',
    password: 'Abc1234!',
  ), // missing local part
];

final kInvalidPasswords = [
  Credentials(
    email: 'test@example.com',
    password: '',
  ), // empty password
  Credentials(
    email: 'test@example.com',
    password: 'Abc1234',
  ), // missing special char
  Credentials(
    email: 'test@example.com',
    password: 'Abc!',
  ), // less than 8 chars
  Credentials(
    email: 'test@example.com',
    password: 'abc1234!',
  ), // missing uppercase
  Credentials(
    email: 'test@example.com',
    password: 'ABC1234!',
  ), // missing lowercase
  Credentials(
    email: 'test@example.com',
    password: 'Abcdefg!',
  ), // missing number
];

final kCredentialsWithoutEmailAndPassword = Credentials(
  email: '',
  password: '',
);