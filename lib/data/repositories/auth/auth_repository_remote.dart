import 'dart:async';

import '../../../domain/models/user/user_model.dart';
import '../../../utils/result.dart';
import '../../models/credentials.dart';
import '../../models/user_state.dart';
import '../../services/api/supabase/auth_service.dart';
import '../../services/local/local_service.dart';
import '../../../domain/repositories/auth/auth_repository.dart';

export '../../../domain/repositories/auth/auth_repository.dart';
export 'auth_repository_provider.dart';

class AuthRepositoryRemote extends AuthRepository {
  AuthRepositoryRemote({
    required AuthService authService,
    required LocalService<UserState> localService,
  }) : _authService = authService,
       _localService = localService;

  FutureResultVoid initialize() async {
    onDataAuthStateChange = OnData(_onDataAuthStateChange);

    final fetched = fetchUser();
    if (fetched is Ok<UserState>) {
      return await setUserState(fetched.value);
    } else {
      return await setUserState(userUnlogged);
    }
  }

  final AuthService _authService;
  final LocalService<UserState> _localService;
  StreamSubscription<AuthState>? _authStateSubscription;

  @override
  Result<UserState> fetchUser() {
    return _localService.get();
  }

  @override
  FutureResult<String> signIn(Credentials credentials) async {
    final result = await _authService.signIn(credentials);
    if (result is Error<User>) return Result.error(result.error);

    final supabaseUser = (result as Ok<User>).value;

    return Result.ok(supabaseUser.id);
  }

  // @override
  // FutureResultVoid signInWithOtp({required String email}) async {
  //   final result = await _authService.signInWithOtp(
  //     Credentials(email: email, password: ''),
  //   );
  //   if (result is Error) return result;
  // }

  @override
  FutureResult<String> signUp(Credentials credentials) async {
    final result = await _authService.signUp(credentials);
    if (result is Error<User>) return Result.error(result.error);

    final supabaseUser = (result as Ok<User>).value;

    return Result.ok(supabaseUser.id);
  }

  @override
  FutureResultVoid signOut() async {
    final result = await _authService.signOut();
    if (result is Error) {
      return result;
    }

    final resultSaveUser = await setUserState(userUnlogged);

    if (resultSaveUser is Error) {
      return resultSaveUser;
    }

    return result;
  }

  @override
  FutureResultVoid resetPassword(Credentials credentials) async {
    final result = await _authService.resetPassword(credentials);
    if (result is Error) return Result.error(result.error);

    return Result.ok(null);
  }

  @override
  FutureResultVoid addAuthStateListener(
    void Function() onAuthStateChange, {
    bool cancelOnError = false,
  }) async {
    await _authStateSubscription?.cancel();

    try {
      onDataAuthStateChange.addListener(onAuthStateChange);

      _authStateSubscription = _authService.supabase.auth.onAuthStateChange
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
  FutureResultVoid removeAuthStateListener(
    void Function() onAuthStateChange,
  ) async {
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

  FutureResult<UserModel> _onDataAuthStateChange(AuthState event) async {
    final session = event.session;

    if (session != null) {
      final userFetched = fetchUser();
      if (userFetched is Error<UserState>) {
        setUserState(UserUnlogged());
        return Result.error(userFetched.error);
      }
      final user = (userFetched as Ok<UserModel>).value;
      setUserState(UserLogged(user));
      return Result.ok(user);
    }

    setUserState(UserUnlogged());
    return Result.error(Exception('No active session'));
  }

  @override
  FutureResultVoid setUserState(UserState newState) async {
    final localResult = await _localService.save(newState);

    if (localResult is Ok) {
      userState.value = newState;
    }

    return localResult;
  }
}
