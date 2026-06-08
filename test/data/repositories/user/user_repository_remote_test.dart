import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_skeleton/data/repositories/user/user_repository_remote.dart';
import 'package:project_skeleton/data/services/api/supabase/api_service.dart';
import 'package:project_skeleton/data/services/api/supabase/filters.dart';
import 'package:project_skeleton/domain/models/user/user_model.dart';
import 'package:project_skeleton/utils/enums/user_role.dart';
import 'package:project_skeleton/utils/result.dart';

class MockAPIService extends Mock implements APIService<UserModel> {}

void main() {
  late UserRepositoryRemote repository;
  late MockAPIService mockAPIService;
  late Users users;

  setUp(() {
    mockAPIService = MockAPIService();

    users = [
      UserModel(
        "1",
        number: '61999999999',
        name: 'test',
        email: 'test@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        role: UserRole.user,
      ),
      UserModel(
        "2",
        number: '61888888888',
        name: 'test2',
        email: 'test2@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        role: UserRole.user,
      ),
    ];

    repository = UserRepositoryRemote(apiService: mockAPIService);
  });

  test('should return user by ID', () async {
    when(
      () => mockAPIService.get(
        filters: any<List<SupabaseFilter>>(
          named: 'filters',
          // that: predicate<List<SupabaseFilter>>((filters) {
          //   final idFilter = filters.firstWhere(
          //     (f) => f.field == 'id' && f.operator == FilterOperator.eq,
          //     orElse: () => throw Exception('ID filter not found'),
          //   );
          //   return idFilter.value == "1";
          // }),
        ),
        limit: any<int>(named: 'limit'),
        offset: any<int>(named: 'offset'),
      ),
    ).thenAnswer((invocation) => Future.value(Result.ok([users.first])));

    final result = await repository.getUser(id: "1");

    expect(result, isA<Ok<UserModel>>());
  });
}
