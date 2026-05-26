import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user/user_model.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';
import '../../../data/models/credentials.dart';
import '../../../data/models/user_state.dart';

typedef OnData = Command1<UserModel, AuthState>;

abstract class AuthRepository {
  AuthRepository();
  ValueNotifier<UserState> userState = ValueNotifier<UserState>(UserUnlogged());

  late OnData onDataAuthStateChange;

  final userUnlogged = UserUnlogged();

  Result<UserState> fetchUser();

  FutureResult<String> signIn(Credentials credentials);
  // feature
  // FutureResultVoid signInWithOtp({required String email});

  FutureResult<String> signUp(Credentials credentials);
  FutureResultVoid signOut();

  FutureResultVoid resetPassword(String email);

  FutureResultVoid addAuthStateListener(
    void Function() listener, {
    bool cancelOnError = false,
  });
  FutureResultVoid removeAuthStateListener(void Function() onAuthStateChange);

  FutureResultVoid setUserState(UserState newState);
}
