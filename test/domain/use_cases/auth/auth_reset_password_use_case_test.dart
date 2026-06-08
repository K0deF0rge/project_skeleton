import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_skeleton/domain/repositories/auth/auth_repository.dart';
import 'package:project_skeleton/domain/use_cases/auth/auth_reset_password_use_case.dart';
import 'package:project_skeleton/utils/exceptions/email_exception.dart';
import 'package:project_skeleton/utils/result.dart';

import '../../../../testing/models/credentials.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late AuthResetPasswordUseCase useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = AuthResetPasswordUseCase(authRepository: authRepository);
  });

  test('returns EmailException for invalid email', () async {
    final rst = await useCase.execute(kInvalidEmails.first);
    expect(rst, isA<Error>());
    expect((rst as Error).error, isA<EmailException>());
  });

  test('returns Exception when resetPassword fails', () async {
    when(
      () => authRepository.resetPassword(kValidCredentials),
    ).thenAnswer((_) async => Result.error(Exception('reset fail')));

    final rst = await useCase.execute(kValidCredentials);

    expect(rst, isA<Error>());

    verify(() => authRepository.resetPassword(kValidCredentials)).called(1);
  });

  test('returns void for valid email', () async {
    when(
      () => authRepository.resetPassword(kValidCredentials),
    ).thenAnswer((_) async => Result.ok(null));

    final rst = await useCase.execute(kValidCredentials);
    expect(rst, isA<Ok>());
  });
}
