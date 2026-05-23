// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../utils/result.dart';
import '../../../../utils/validators/credentials_validator.dart';

export 'package:supabase_flutter/supabase_flutter.dart';
export 'package:flutter/foundation.dart';

class AuthService {
  AuthService({required this.supabase});
  final SupabaseClient supabase;

  // feature
  // FutureResultVoid signInWithOtp(Credentials credentials) async {
  //   final redirect = kIsWeb ? Uri.base.origin : dotenv.get('EMAIL_REDIRECT_TO');
  //   try {
  //     await supabase.auth.signInWithOtp(
  //       email: credentials.email,
  //       emailRedirectTo: redirect,
  //     );

  //     return Result.ok(null);
  //   } on AuthException catch (error) {
  //     return Result.error(error);
  //   } on Exception catch (error) {
  //     return Result.error(error);
  //   } catch (error) {
  //     return Result.error(Exception('Unknown error'));
  //   }
  // }

  FutureResult<User> signIn(Credentials credentials) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: credentials.email,
        password: credentials.password,
      );

      return Result.ok(res.user!);
    } on AuthException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception(error));
    }
  }

  FutureResultVoid resetPassword(
    Credentials credentials,
  ) async {
    try {
      await supabase.auth.resetPasswordForEmail(credentials.email);

      return const Result.ok(null);
    } on AuthException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception(error));
    }
  }

  FutureResult<User> signUp(Credentials credentials) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: credentials.email,
        password: credentials.password,
        data: {"full_name": credentials.email, "phone": "", "role": "owner"},
      );

      return Result.ok(res.user!);
    } on AuthException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception(error));
    }
  }

  FutureResultVoid signOut() async {
    try {
      await supabase.auth.signOut();

      return const Result.ok(null);
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception(error));
    }
  }
}