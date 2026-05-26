import 'package:flutter_test/flutter_test.dart';
import 'package:project_skeleton/utils/validators/credentials_validator.dart';

import '../../../testing/models/credentials.dart';

void main() {
  group('validate valid credentials', () {
    test('should accept valid credentials', () {
      final result = CredentialsValidator.validate(kValidCredentials);
      expect(result, isNull);
    });
  });

  group('validate invalid emails', () {
    test('should reject all invalid email cases', () {
      for (final credentials in kInvalidEmails) {
        final result = CredentialsValidator.validate(credentials);
        expect(
          result,
          isNotNull,
          reason: 'Email "${credentials.email}" should be invalid',
        );
      }
    });
  });

  group('validate invalid passwords', () {
    test('should reject all invalid password cases', () {
      for (final credentials in kInvalidPasswords) {
        final result = CredentialsValidator.validate(credentials);
        expect(
          result,
          isNotNull,
          reason: 'Password "${credentials.password}" should be invalid',
        );
      }
    });
  });

  group('validate email and password together', () {
    test('should reject when both email and password are invalid', () {
      final result = CredentialsValidator.validate(
        kCredentialsWithoutEmailAndPassword,
      );
      expect(result, isNotNull);
    });
  });
}