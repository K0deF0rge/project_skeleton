import 'package:flutter_test/flutter_test.dart';
import 'package:mock_supabase_http_client/mock_supabase_http_client.dart';
import 'package:project_skeleton/data/services/api/supabase/filters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:project_skeleton/data/services/api/supabase/api_service.dart';
import 'package:project_skeleton/utils/result.dart';

import '../../../../../testing/models/user_model.dart';

void main() {
  late final SupabaseClient mockSupabase;
  late final MockSupabaseHttpClient mockHttpClient;
  late APIService<UserModel> apiService;

  setUpAll(() async {
    mockHttpClient = MockSupabaseHttpClient();

    mockSupabase = SupabaseClient(
      'https://mock.supabase.co',
      'fakeAnonKey',
      httpClient: MockSupabaseHttpClient(),
    );

    await mockSupabase
        .from(UserModel.getTableName())
        .insert(kUserModels.map((m) => m.toJson()).toList());

    apiService = APIService<UserModel>(
      supabase: mockSupabase,
      tableName: UserModel.getTableName(),
      fromJson: UserModel.fromJson,
    );
  });

  tearDown(() {
    mockHttpClient.reset();
  });

  tearDownAll(() {
    mockHttpClient.close();
  });

  group('create', () {
    test('should create a record successfully', () async {
      final result = await apiService.create(kUserModel);

      expect(result, isA<Ok>());
    });

    // test('should handle PostgrestException on create, because the record already exists', () async {
    //   final result = await apiService.create(kUserModel);

    //   expect(result, isA<Error>());
    // });
  });

  group('get', () {
    test('should get all records without limit', () async {
      final result = await apiService.get();

      expect(result, isA<Ok<List<UserModel>>>());
      expect((result as Ok<List<UserModel>>).value.length, equals(3));
    });

    test('should get records with custom limit and offset', () async {
      final result = await apiService.get(limit: 1, offset: 0);

      expect(result, isA<Ok<List<UserModel>>>());
      expect((result as Ok<List<UserModel>>).value.length, equals(1));
    });

    test('should get records with custom filter', () async {
      List<SupabaseFilter> filters = [
        SupabaseFilter('id', FilterOperator.eq, 1),
      ];
      final result = await apiService.get(filters: filters);

      expect(result, isA<Ok<List<UserModel>>>());
      final user = (result as Ok<List<UserModel>>).value.first;

      expect(user.name, equals(kUserModel.name));
      expect(result.value.length, equals(1));
    });
  });

  group('update', () {
    test('should update a record successfully', () async {
      final newName = 'Updated Name';
      List<SupabaseFilter> filters = [
        SupabaseFilter('id', FilterOperator.eq, 1),
      ];

      final resultGet = await apiService.get(filters: filters);
      final user = (resultGet as Ok<List<UserModel>>).value.first;
      expect(user.name, equals(kUserModel.name));

      final updatedUser = UserModel(
        id: user.id,
        name: newName,
        email: user.email,
      );

      final result = await apiService.update(updatedUser);
      expect(result, isA<Ok>());

      final resultGet2 = await apiService.get(filters: filters);
      final user2 = (resultGet2 as Ok<List<UserModel>>).value.first;
      expect(user2.name, equals(newName));
    });
  });

  group('delete', () {
    test('should delete a record successfully', () async {
      final id = '3';
      final resultDelete = await apiService.delete(id);

      expect(resultDelete, isA<Ok>());

      final resultGet = await apiService.get();

      expect(resultGet, isA<Ok<List<UserModel>>>());
      expect((resultGet as Ok<List<UserModel>>).value.length, equals(2));

      final deletedUser = resultGet.value.where((u) => u.id == id);
      expect(deletedUser.isEmpty, isTrue);
    });
  });
}
