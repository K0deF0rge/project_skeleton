import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:project_skeleton/data/repositories/auth/auth_repository_remote.dart';
import 'package:project_skeleton/data/models/user_state.dart';
import 'package:project_skeleton/data/services/api/supabase/auth_service.dart';
import 'package:project_skeleton/data/services/local/local_service.dart';
import 'package:project_skeleton/domain/models/user/user_model.dart';
import 'package:project_skeleton/utils/enums/user_role.dart';
import 'package:project_skeleton/utils/result.dart';

import '../../../../testing/mocks/auth/mock_supabase_client.dart';
import '../../../../testing/models/credentials.dart';

class MockLocalService extends Mock implements LocalService<UserState> {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  final userId = 'user-123';
  late MockAuthService mockAuthService;
  late MockLocalService mockLocalService;
  late AuthRepositoryRemote repository;
  late MockUser mockUser;
  late UserModel userModel;
  late UserState userState;

  setUp(() {
    mockAuthService = MockAuthService();
    mockLocalService = MockLocalService();
    mockUser = MockUser();

    userModel = UserModel(
      'uuid_test',
      number: '61999999999',
      name: 'test',
      email: 'test@example.com',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      role: UserRole.owner,
    );

    userState = UserLogged(userModel);
  });

  group('fetchUser', () {
    test('should return user when local service has user', () async {
      when(() => mockLocalService.get()).thenReturn(Result.ok(userState));

      when(
        () => mockLocalService.save(userState),
      ).thenAnswer((_) async => const Result.ok(null));

      repository = AuthRepositoryRemote(
        authService: mockAuthService,
        localService: mockLocalService,
      );

      final resultInitialize = await repository.initialize();

      expect(resultInitialize, isA<Ok<void>>());

      final resultFetchUser = repository.fetchUser();

      expect(resultFetchUser, isA<Ok<UserState>>());
      expect((resultFetchUser as Ok<UserState>).value, isA<UserLogged>());
      expect(
        (resultFetchUser.value as UserLogged).user.id,
        equals(userModel.id),
      );
    });

    test('should return error when no user is saved locally', () async {
      when(
        () => mockLocalService.get(),
      ).thenReturn(Result.error(Exception('No data')));

      repository = AuthRepositoryRemote(
        authService: mockAuthService,
        localService: mockLocalService,
      );

      when(
        () => mockLocalService.save(repository.userUnlogged),
      ).thenAnswer((_) async => const Result.ok(null));

      await repository.initialize();

      expect(repository.userState.value, isA<UserUnlogged>());
    });
  });

  group('signIn', () {
    test('should return user id when sign in succeeds', () async {
      when(
        () => mockAuthService.signIn(kValidCredentials),
      ).thenAnswer((_) async => Result.ok(mockUser));

      repository = AuthRepositoryRemote(
        authService: mockAuthService,
        localService: mockLocalService,
      );

      final result = await repository.signIn(kValidCredentials);

      expect(result, isA<Ok<String>>());
      expect((result as Ok<String>).value, equals(userId));
    });
  });

  group('signUp', () {
    test('should return user id when sign up succeeds', () async {
      when(
        () => mockAuthService.signUp(kValidCredentials),
      ).thenAnswer((_) async => Result.ok(mockUser));

      repository = AuthRepositoryRemote(
        authService: mockAuthService,
        localService: mockLocalService,
      );

      final result = await repository.signUp(kValidCredentials);

      expect(result, isA<Ok<String>>());
      expect((result as Ok<String>).value, equals(userId));
    });
  });

  group('resetPassword', () {
    test('should return Ok when reset password succeeds', () async {
      when(
        () => mockAuthService.resetPassword(kValidCredentials),
      ).thenAnswer((_) async => const Result.ok(null));

      repository = AuthRepositoryRemote(
        authService: mockAuthService,
        localService: mockLocalService,
      );

      final result = await repository.resetPassword(kValidCredentials);

      expect(result, isA<Ok>());
    });
  });

  group('signOut', () {
    test('should sign out and set user state to unlogged', () async {
      when(
        () => mockAuthService.signOut(),
      ).thenAnswer((_) async => const Result.ok(null));

      repository = AuthRepositoryRemote(
        authService: mockAuthService,
        localService: mockLocalService,
      );

      when(
        () => mockLocalService.save(repository.userUnlogged),
      ).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.signOut();

      expect(result, isA<Ok>());
      expect(repository.userState.value, isA<UserUnlogged>());
    });
  });
}
