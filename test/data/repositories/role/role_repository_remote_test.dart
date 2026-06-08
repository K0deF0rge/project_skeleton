import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_skeleton/data/repositories/role/role_repository_remote.dart';
import 'package:project_skeleton/data/services/api/supabase/api_service.dart';
import 'package:project_skeleton/data/services/api/supabase/filters.dart';
import 'package:project_skeleton/domain/models/role/role_model.dart';
import 'package:project_skeleton/utils/result.dart';

class MockAPIService extends Mock implements APIService<RoleModel> {}

void main() {
  final userId = 'user-123';

  late RoleRepositoryRemote repository;
  late MockAPIService mockAPIService;
  late Roles roles;

  setUp(() {
    mockAPIService = MockAPIService();

    roles = [
      RoleModel(1, userId: userId, module: Modules.products),
      RoleModel(2, userId: userId, module: Modules.users),
    ];

    repository = RoleRepositoryRemote(apiService: mockAPIService);
  });

  test('should fetch roles by user ID', () async {
    when(
      () => mockAPIService.get(
        filters: any<List<SupabaseFilter>>(named: 'filters'),
        noLimit: any<bool>(named: 'noLimit'),
      ),
    ).thenAnswer((invocation) => Future.value(Result.ok(roles)));

    final result = await repository.getRolesByUserId(userId);

    expect(result, isA<Ok<Roles>>());
  });
}
