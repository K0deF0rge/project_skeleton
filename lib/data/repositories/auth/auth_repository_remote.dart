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
    required this.authService,
    required this.localService,
  }) {
    onDataAuthStateChange = OnData(_onDataAuthStateChange);

    final fetched = fetchUser();
    if (fetched is Ok<UserModel>) {
      setUserState(UserLogged(fetched.value));
    } else {
      setUserState(UserUnlogged());
    }
  }

  final AuthService authService;
  final LocalService<UserState> localService;
  StreamSubscription<AuthState>? _authStateSubscription;

  @override
  Result<UserModel> fetchUser() {
    final result = localService.get();

    if (result is Error<UserState>) return Result.error(result.error);

    if (result is Ok<UserState>) {
      return Result.ok((result.value as UserLogged).user);
    }

    return Result.error(Exception('Unknown error'));
  }

  @override
  FutureResult<String> signIn(Credentials credentials) async {
    final result = await authService.signIn(credentials);
    if (result is Error<User>) return Result.error(result.error);

    final supabaseUser = (result as Ok<User>).value;

    return Result.ok(supabaseUser.id);
  }

  // @override
  // FutureResultVoid signInWithOtp({required String email}) async {
  //   final result = await authService.signInWithOtp(
  //     Credentials(email: email, password: ''),
  //   );
  //   if (result is Error) return result;
  // }

  @override
  FutureResult<String> signUp(Credentials credentials) async {
    final result = await authService.signUp(credentials);
    if (result is Error<User>) return Result.error(result.error);

    final supabaseUser = (result as Ok<User>).value;

    return Result.ok(supabaseUser.id);
  }

  @override
  FutureResultVoid signOut() async {
    final result = await authService.signOut();
    if (result is Error) {
      return result;
    }

    final resultSaveUser = await setUserState(UserUnlogged());
    ;

    if (resultSaveUser is Error) {
      return resultSaveUser;
    }

    return result;
  }

  @override
  FutureResultVoid resetPassword(String email) async {
    final result = await authService.resetPassword(
      Credentials(email: email, password: ''),
    );
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
      if (userFetched is Error) {
        setUserState(UserUnlogged());
        return userFetched;
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
    userState.value = newState;
    final localResult = await localService.save(newState);
    if (localResult is Error) return Result.error(localResult.error);

    return const Result.ok(null);
  }
}
