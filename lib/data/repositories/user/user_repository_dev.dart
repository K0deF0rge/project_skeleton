import '../../../domain/models/user/user_model.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/result.dart';
import '../../../domain/repositories/user/user_repository.dart';

class UserRepositoryDev extends UserRepository {
  UserRepositoryDev({required super.service});

  @override
  FutureResult<UserModel> getUser({required String id}) async {
    return Result.ok(
      UserModel(
        id,
        name: 'Dev User',
        email: '',
        number: '',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        role: UserRole.owner,
      ),
    );
  }
  
  @override
  FutureResult<Users> getUsers() async {
    final usersMock = [
      UserModel(
        '1',
        name: 'Alice Green',
        email: 'alice.green@example.com',
        number: '+1 555 0101',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        role: UserRole.user,
      ),
      UserModel(
        '2',
        name: 'Bob Smith',
        email: 'bob.smith@example.com',
        number: '+1 555 0102',
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        role: UserRole.user,
      ),
      UserModel(
        '3',
        name: 'Carol Johnson',
        email: 'carol.johnson@example.com',
        number: '+1 555 0103',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now(),
        role: UserRole.user,
      ),
    ];

    return Result.ok(usersMock);
  }
}
