import 'dart:async';

import '../../../core/logger.dart';
import '../../../domain/models/role/role.dart';
import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';
import '../../model/user_state.dart';
import '../../services/api/supabase/api_service.dart';
import '../../services/api/supabase/auth_service.dart';
import '../../services/local/local_service.dart';
import '../role/role_repository_remote.dart';
import '../user/user_repository_remote.dart';
import 'auth_repository.dart';

export 'auth_repository.dart';
export 'auth_repository_provider.dart';

class AuthRepositoryRemote extends AuthRepository {
  AuthRepositoryRemote({
    required this.authService,
    required this.localService,
  }) {
    onDataAuthStateChange = OnData(_onDataAuthStateChange);

    final fetched = fetchUser();
    AppLogger.debug("AuthRepositoryRemote: fetched user on init: $fetched");
    if (fetched is Ok<UserModel>) {
      userState.value = UserLogged(fetched.value);
    } else {
      userState.value = UserUnlogged();
    }
  }

  final AuthService authService;
  final LocalService<UserState> localService;

  @override
  Result<UserModel> fetchUser() {
    final result = localService.get();
    AppLogger.debug("AuthRepositoryRemote: fetchUser $result");

    if (result is Error<UserState>) return Result.error(result.error);

    if (result is Ok<UserState>) {
      return Result.ok((result.value as UserLogged).user);
    }

    return Result.error(Exception('Unknown error fetching user'));
  }

  @override
  Future<Result<void>> signOut() async {
    final result = await authService.signOut();
    if (result is Error) {
      return result;
    }

    final resultSaveUser = await localService.save(UserUnlogged());

    if (resultSaveUser is Error) {
      return resultSaveUser;
    }

    userState.value = UserUnlogged();

    return result;
  }

  @override
  FutureResult<String> signIn(SignCredentials credentials) async {
    final result = await authService.signIn(credentials);
    AppLogger.debug('AuthRepositoryRemote: signIn result: $result');
    if (result is Error<User>) return Result.error(result.error);

    final supabaseUser = (result as Ok<User>).value;
    final userRepo = UserRepositoryRemote(
      apiService: APIService<UserModel>(
        supabase: authService.supabase,
        tableName: UserModel.getTableName(),
        fromJson: UserModel.fromJson,
      ),
    );

    AppLogger.debug(
      'AuthRepositoryRemote: sign supabaseUser.id: ${supabaseUser.id}',
    );

    final userResult = await userRepo.getUser(id: supabaseUser.id);

    AppLogger.debug('AuthRepositoryRemote: userResult: $userResult');

    if (userResult is Error<UserModel>) {
      return Result.error(userResult.error);
    }

    final userWithoutRoles = (userResult as Ok<UserModel>).value;

    final roleRepo = RoleRepositoryRemote(
      service: APIService<Role>(
        supabase: authService.supabase,
        tableName: Role.getTableName(),
        fromJson: Role.fromJson,
      ),
    );

    final roleResult = await roleRepo.getRolesByUserId(supabaseUser.id);
    AppLogger.debug('AuthRepositoryRemote: roleResult: $roleResult');

    if (roleResult is Error<List<Role>>) {
      return Result.error(roleResult.error);
    }

    final roles = (roleResult as Ok<List<Role>>).value;

    final user = UserModel(
      userWithoutRoles.id,
      number: userWithoutRoles.number,
      name: userWithoutRoles.name,
      email: userWithoutRoles.email,
      createdAt: userWithoutRoles.createdAt,
      updatedAt: userWithoutRoles.updatedAt,
      role: userWithoutRoles.role,
      roles: roles,
    );

    final userLogged = UserLogged(user);
    AppLogger.debug('AuthRepositoryRemote: save user $userLogged');
    final localResult = await localService.save(userLogged);
    if (localResult is Error) return Result.error(localResult.error);

    userState.value = userLogged;

    return const Result.ok('login efetuado');
  }

  @override
  Future<Result<String>> signInWithOtp({required String email}) async {
    final result = await authService.signInWithOtp(
      LoginWithOtpRequest(email: email),
    );
    return result;
  }

  @override
  FutureResult<String> signUp(SignCredentials credentials) async {
    final result = await authService.signUp(credentials);
    if (result is Error) return Result.error((result as Error).error);
    return const Result.ok(
      'Cadastro realizado com sucesso! Valide o seu e-mail antes de fazer login.',
    );
  }

  @override
  Future<Result<String>> resetPassword(String email) async {
    final result = await authService.resetPassword(
      ResetPasswordRequest(email: email),
    );
    return result;
  }

  StreamSubscription<AuthState>? _authStateSubscription;

  @override
  Future<Result<void>> addAuthStateListener(
    void Function() onAuthStateChange, {
    bool cancelOnError = false,
  }) async {
    await _authStateSubscription?.cancel();

    try {
      onDataAuthStateChange.addListener(onAuthStateChange);

      _authStateSubscription = authService.supabase.auth.onAuthStateChange
          .listen(
            onDataAuthStateChange.execute,
            onError: (error) {},
            cancelOnError: cancelOnError,
          );

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to add auth state listener: $e'));
    }
  }

  @override
  Future<Result<void>> removeAuthStateListener(void Function() onAuthStateChange) async {
    try {
      await _authStateSubscription?.cancel();
      onDataAuthStateChange.removeListener(onAuthStateChange);
      _authStateSubscription = null;
      return const Result.ok(null);
    } catch (e) {
      return Result.error(
        Exception('Failed to remove auth state listener: $e'),
      );
    }
  }

  Future<Result<UserModel>> _onDataAuthStateChange(AuthState event) async {
    final session = event.session;
    AppLogger.debug('\n authRepositoryRemote: _onDataAuthStateChange $event\n');
    if (session != null) {
      final userFetched = fetchUser();
      if (userFetched is Error) {
        userState.value = UserUnlogged();
        return userFetched;
      }
      final user = (userFetched as Ok<UserModel>).value;
      userState.value = UserLogged(user);
      return Result.ok(user);
    }

    userState.value = UserUnlogged();
    return Result.error(Exception('No active session'));
  }
}
