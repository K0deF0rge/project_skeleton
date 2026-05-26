import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockUser extends Mock implements User {
  MockUser() {
    when(() => id).thenReturn('user-123');
  }
}

class MockGoTrueClient extends Mock implements GoTrueClient {}

// class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

// class MockPostgrestFilterBuilder extends Mock
//     implements PostgrestFilterBuilder<PostgrestList> {}

// class MockPostgrestTransformBuilder extends Mock
//     implements PostgrestTransformBuilder<PostgrestList> {}

class MockSupabaseClient extends Mock implements SupabaseClient {
  @override
  late final GoTrueClient auth;
}

// extension SupabaseClientMocks on MockSupabaseClient {
//   void mockFrom(String table, List<Map<String, dynamic>> response) {
//     when(() => from(table)).thenAnswer((invocation) {
//       final supabaseQueryBuilder = MockSupabaseQueryBuilder();
//       final postgrestFilterBuilder = MockPostgrestFilterBuilder();
//       final postgrestTransformBuilder = MockPostgrestTransformBuilder();

//       when(
//         () => supabaseQueryBuilder.select(),
//       ).thenReturn(postgrestFilterBuilder);

//       when(
//         () => postgrestFilterBuilder.filter(any(), any(), any()),
//       ).thenReturn(postgrestFilterBuilder);

//       when(
//         () => postgrestFilterBuilder.range(any(), any()),
//       ).thenReturn(postgrestTransformBuilder);

//       when(
//         () => postgrestTransformBuilder.then(any(), onError: any(named: 'onError')),
//       ).thenAnswer((invocation) async {
//         final onValue = invocation.positionalArguments[0] as dynamic;
//         return onValue(response);
//       });

//       return supabaseQueryBuilder;
//     });
//   }
// }
