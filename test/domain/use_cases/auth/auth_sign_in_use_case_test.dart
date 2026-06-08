import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_skeleton/data/models/user_state.dart';
import 'package:project_skeleton/domain/repositories/auth/auth_repository.dart';
import 'package:project_skeleton/domain/repositories/role/role_repository.dart';
import 'package:project_skeleton/domain/repositories/user/user_repository.dart';
import 'package:project_skeleton/domain/use_cases/auth/auth_sign_in_use_case.dart';
import 'package:project_skeleton/utils/exceptions/credentials_exception.dart';
import 'package:project_skeleton/utils/result.dart';

import '../../../../testing/models/credentials.dart';
import '../../../../testing/models/user_model.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockRoleRepository extends Mock implements RoleRepository {}

class FakeUserState extends Fake implements UserState {}

void main() {
  late AuthRepository authRepository;
  late UserRepository userRepository;
  late RoleRepository roleRepository;
  late AuthSignInUseCase useCase;

  setUpAll(() {
    registerFallbackValue(FakeUserState());
  });

  setUp(() {
    authRepository = MockAuthRepository();
    userRepository = MockUserRepository();
    roleRepository = MockRoleRepository();
    useCase = AuthSignInUseCase(
      authRepository: authRepository,
      userRepository: userRepository,
      roleRepository: roleRepository,
    );
  });

  test('returns CredentialsException for invalid credential', () async {
    final rst = await useCase.execute(kInvalidEmails.first);
    expect(rst, isA<Error>());
    expect((rst as Error).error, isA<CredentialsException>());
  });

  test('returns Exception when signIn fails', () async {
    when(
      () => authRepository.signIn(kValidCredentials),
    ).thenAnswer((_) async => Result.error(Exception('network')));

    final rst = await useCase.execute(kValidCredentials);

    expect(rst, isA<Error>());
    expect((rst as Error).error, isA<Exception>());
    verify(() => authRepository.signIn(kValidCredentials)).called(1);
  });

  test('returns Exception when getUser fails', () async {
    when(
      () => authRepository.signIn(kValidCredentials),
    ).thenAnswer((_) async => Result.ok(uuidDevUser1));

    when(
      () => userRepository.getUser(id: uuidDevUser1),
    ).thenAnswer((_) async => Result.error(Exception('not found')));

    final rst = await useCase.execute(kValidCredentials);

    expect(rst, isA<Error>());
    verify(() => userRepository.getUser(id: uuidDevUser1)).called(1);
  });

  test('returns Exception when getRolesByUserId fails', () async {
    when(
      () => authRepository.signIn(kValidCredentials),
    ).thenAnswer((_) async => Result.ok(uuidDevUser1));

    when(
      () => userRepository.getUser(id: uuidDevUser1),
    ).thenAnswer((_) async => Result.ok(kUserModel));

    when(
      () => roleRepository.getRolesByUserId(uuidDevUser1),
    ).thenAnswer((_) async => Result.error(Exception('getRolesByUserId fail')));

    final rst = await useCase.execute(kValidCredentials);

    expect(rst, isA<Error>());
    verify(() => roleRepository.getRolesByUserId(uuidDevUser1)).called(1);
  });

  test('returns Exception when setUserState fails', () async {
    when(
      () => authRepository.signIn(kValidCredentials),
    ).thenAnswer((_) async => Result.ok(uuidDevUser1));

    when(
      () => userRepository.getUser(id: uuidDevUser1),
    ).thenAnswer((_) async => Result.ok(kUserModel));

    when(
      () => roleRepository.getRolesByUserId(uuidDevUser1),
    ).thenAnswer((_) async => Result.ok(kRoleModels));

    when(
      () => authRepository.setUserState(any()),
    ).thenAnswer((_) async => Result.error(Exception('set state fail')));

    final rst = await useCase.execute(kValidCredentials);

    expect(rst, isA<Error>());
    verify(() => authRepository.setUserState(any())).called(1);
  });

  test('returns void for valid credential', () async {
    when(
      () => authRepository.signIn(kValidCredentials),
    ).thenAnswer((_) async => Result.ok(uuidDevUser1));

    when(
      () => userRepository.getUser(id: uuidDevUser1),
    ).thenAnswer((_) async => Result.ok(kUserModel));

    when(
      () => roleRepository.getRolesByUserId(uuidDevUser1),
    ).thenAnswer((_) async => Result.ok(kRoleModels));

    when(
      () => authRepository.setUserState(any()),
    ).thenAnswer((_) async => Result.ok(null));

    final rst = await useCase.execute(kValidCredentials);

    expect(rst, isA<Ok>());
    // capturar o argumento passado para setUserState e verificar roles
    final verification = verify(
      () => authRepository.setUserState(captureAny()),
    );
    final captured = verification.captured;
    expect(captured, isNotEmpty);
    final passedState = captured.first as UserLogged;
    expect(passedState.user.roles, equals(kRoleModels));
  });
}
