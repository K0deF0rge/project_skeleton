import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_skeleton/domain/models/user/user_model.dart';
import 'package:project_skeleton/domain/repositories/role/role_repository.dart';
import 'package:project_skeleton/domain/repositories/user/user_repository.dart';
import 'package:project_skeleton/domain/use_cases/users/users_get_user_use_case.dart';
import 'package:project_skeleton/utils/result.dart';

import '../../../../testing/models/user_model.dart'; //

class MockUserRepository extends Mock implements UserRepository {}

class MockRoleRepository extends Mock implements RoleRepository {}

void main() {
  late UserRepository userRepository;
  late RoleRepository roleRepository;
  late UsersGetUserUseCase useCase;

  setUp(() {
    userRepository = MockUserRepository();
    roleRepository = MockRoleRepository();
    useCase = UsersGetUserUseCase(
      userRepository: userRepository,
      roleRepository: roleRepository,
    );
  });

  test('returns Exception when getUser fails', () async {
    when(
      () => userRepository.getUser(id: uuidDevUser1),
    ).thenAnswer((_) async => Result.error(Exception('not found')));

    final rst = await useCase.execute(uuidDevUser1);

    expect(rst, isA<Error>());
    verify(() => userRepository.getUser(id: uuidDevUser1)).called(1);
  });

  test('returns Exception when getRolesByUserId fails', () async {
    when(
      () => userRepository.getUser(id: uuidDevUser1),
    ).thenAnswer((_) async => Result.ok(kUserModel));

    when(
      () => roleRepository.getRolesByUserId(uuidDevUser1),
    ).thenAnswer((_) async => Result.error(Exception('getRolesByUserId fail')));

    final rst = await useCase.execute(uuidDevUser1);

    expect(rst, isA<Error>());
    verify(() => roleRepository.getRolesByUserId(uuidDevUser1)).called(1);
  });

  test('returns void when all operations succeed', () async {
    when(
      () => userRepository.getUser(id: uuidDevUser1),
    ).thenAnswer((_) async => Result.ok(kUserModel));

    when(
      () => roleRepository.getRolesByUserId(uuidDevUser1),
    ).thenAnswer((_) async => Result.ok(kRoleModels));

    final rst = await useCase.execute(uuidDevUser1);

    expect(rst, isA<Ok<UserModel>>());
    expect((rst as Ok<UserModel>).value, equals(kUserModel));
  });
}
