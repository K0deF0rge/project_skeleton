import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_skeleton/data/services/api/supabase/auth_service.dart';
import 'package:project_skeleton/utils/result.dart';

import '../../../../../testing/mocks/auth/mock_supabase_client.dart';
import '../../../../../testing/models/credentials.dart';

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late AuthService authService;
  late MockUser user;

  setUp(() {
    mockGoTrueClient = MockGoTrueClient();
    mockSupabaseClient = MockSupabaseClient()..auth = mockGoTrueClient;
    user = MockUser();

    authService = AuthService(supabase: mockSupabaseClient);
  });

  group('Sign in', () {
    test('should sign in successfully with valid credentials', () async {
      when(
        () => mockGoTrueClient.signInWithPassword(
          email: kValidCredentials.email,
          password: kValidCredentials.password,
        ),
      ).thenAnswer((_) async => AuthResponse(user: user));

      final result = await authService.signIn(kValidCredentials);

      expect(result, isA<Ok<User>>());
    });
  });

  group('Sign up', () {
    test('should sign up successfully with valid credentials', () async {
      when(
        () => mockGoTrueClient.signUp(
          email: kValidCredentials.email,
          password: kValidCredentials.password,
          data: {
            "full_name": kValidCredentials.email,
            "phone": "",
            "role": "owner",
          },
        ),
      ).thenAnswer((_) async => AuthResponse(user: user));

      final result = await authService.signUp(kValidCredentials);

      expect(result, isA<Ok<User>>());
    });
  });

  group('Reset password', () {
    test('should reset password successfully with valid email', () async {
      when(
        () => mockGoTrueClient.resetPasswordForEmail(kValidCredentials.email),
      ).thenAnswer((_) async {});

      final result = await authService.resetPassword(kValidCredentials);

      expect(result, isA<Ok>());
    });
  });

  group('Sign out', () {
    test('should sign out successfully', () async {
      when(() => mockGoTrueClient.signOut()).thenAnswer((_) async {});

      final result = await authService.signOut();

      expect(result, isA<Ok>());
    });
  });
}
