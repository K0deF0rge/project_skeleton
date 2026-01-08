import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/models/user/user.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';
import '../../model/sign_credentials.dart';
import '../../model/user_state.dart';

typedef OnData = Command1<UserModel, AuthState>;

abstract class AuthRepository {
  AuthRepository();
  ValueNotifier<UserState> userState = ValueNotifier<UserState>(UserUnlogged());
  late OnData onDataAuthStateChange;

  Result<UserModel> fetchUser();

  FutureResult<String> signIn(SignCredentials credentials);
  Future<Result<String>> signInWithOtp({required String email});

  FutureResult<String> signUp(SignCredentials credentials);
  Future<Result<void>> signOut();

  Future<Result<String>> resetPassword(String email);

  Future<Result<void>> addAuthStateListener(void Function() listener, {bool cancelOnError = false});
  Future<Result<void>> removeAuthStateListener(void Function() onAuthStateChange);
}
