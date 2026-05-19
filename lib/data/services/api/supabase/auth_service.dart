import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/logger.dart';
import '../../../../utils/result.dart';
import '../../../../utils/validators/validators.dart';
import '../../../model/models.dart';

export 'package:supabase_flutter/supabase_flutter.dart';
export 'package:flutter/foundation.dart';
export '../../../model/models.dart';

typedef SigninResult = FutureResult<SigninResponse>;
typedef SignupResult = FutureResult<SignupResponse>;

class AuthService {
  AuthService({required this.supabase});
  final SupabaseClient supabase;

  Future<Result<String>> signInWithOtp(LoginWithOtpRequest loginRequest) async {
    final redirect = kIsWeb ? Uri.base.origin : dotenv.get('EMAIL_REDIRECT_TO');
    try {
      final resultValidate = EmailValidator.validate(loginRequest.email);
      if (resultValidate != null) return Result.error(resultValidate);

      await supabase.auth.signInWithOtp(
        email: loginRequest.email,
        emailRedirectTo: redirect,
      );

      return Result.ok('Link mágico enviado para ${loginRequest.email}');
    } on AuthException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  FutureResult<User> signIn(SignCredentials credentials) async {
    try {
      final resultValidate = EmailValidator.validate(credentials.email);
      if (resultValidate != null) return Result.error(resultValidate);

      final resultPasswordValidator = PasswordValidator.validate(
        credentials.password,
      );
      if (resultPasswordValidator != null) {
        return Result.error(resultPasswordValidator);
      }

      final res = await supabase.auth.signInWithPassword(
        email: credentials.email,
        password: credentials.password,
      );

      AppLogger.debug('auth_service: signin res.user ${res.user}');
      AppLogger.debug('auth_service: signin res.session ${res.session}');

      return Result.ok(res.user!);
    } on AuthException catch (error) {
      AppLogger.error('auth_service: signin authException ${error.message}', error, stackTrace: StackTrace.current);
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  Future<Result<String>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  ) async {
    try {
      final resultValidate = EmailValidator.validate(
        resetPasswordRequest.email,
      );
      if (resultValidate != null) return Result.error(resultValidate);

      await supabase.auth.resetPasswordForEmail(resetPasswordRequest.email);

      AppLogger.debug(
        'auth_service: reset password currrentuser ${supabase.auth.currentUser}',
      );

      return const Result.ok(
        'E-mail de redefinição enviado! Verifique sua caixa de entrada.',
      );
    } on AuthException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  FutureResult<User> signUp(SignCredentials credentials) async {
    try {
      final resultEmailValidator = EmailValidator.validate(credentials.email);
      if (resultEmailValidator != null) {
        return Result.error(resultEmailValidator);
      }

      final resultPasswordValidator = PasswordValidator.validate(
        credentials.password,
      );
      if (resultPasswordValidator != null) {
        return Result.error(resultPasswordValidator);
      }

      final AuthResponse res = await supabase.auth.signUp(
        email: credentials.email,
        password: credentials.password,
        data: {"full_name": credentials.email, "phone": "", "role": "owner"},
      );

      AppLogger.debug('auth_service: Signup res ${res.user}');
      return Result.ok(res.user!);
    } on AuthException catch (error) {
      AppLogger.error('auth_service: Signup error ${error.message}', error, stackTrace: StackTrace.current);

      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  Future<Result<String>> signOut() async {
    try {
      await supabase.auth.signOut();

      return const Result.ok("Deslogado");
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }
}