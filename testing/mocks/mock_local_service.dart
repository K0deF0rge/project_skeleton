import 'package:mocktail/mocktail.dart';
import 'package:project_skeleton/utils/enums/user_role.dart';

import 'package:project_skeleton/data/models/user_state.dart';
import 'package:project_skeleton/data/services/local/local_service.dart';
import 'package:project_skeleton/domain/models/user/user_model.dart';
import 'package:project_skeleton/utils/result.dart';

class MockLocalService extends Mock implements LocalService<UserState> {
  @override
  Result<UserState> get({String key = ''}) {
    final userLogged = UserLogged(
      UserModel(
        '1',
        email: 'user1@gmail.com',
        number: '12345678910',
        name: 'User 1',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        updatedAt: DateTime.now().subtract(Duration(days: 1)),
        role: UserRole.owner,
      ),
    );
    return Result.ok(userLogged);
  }

  @override
  FutureResultVoid save(UserState model, {String key = ''}) async {
    return const Result.ok(null);
  }
}