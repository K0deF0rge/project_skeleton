import '../../../domain/models/base.dart';
import '../../../domain/models/user/user.dart';

class UserState extends BaseModel {
  @override
  Map<String, dynamic> toJson() {
    switch (this) {
      case UserLoading _:
        return {"type": "loading"};

      case UserUnlogged _:
        return {"type": "unlogged"};

      case UserLogged userLogged:
        return {"type": "logged", "user": userLogged.user.toJson()};

      default:
        return {"type": "unknown"};
    }
  }

  @override
  BaseModel toModel(Map<String, dynamic> json) {
    final type = json['type'];
    switch (type) {
      case 'loading':
        return UserLoading();

      case 'unlogged':
        return UserUnlogged();

      case 'logged':
        final userJson = json['user'] as Map<String, dynamic>;
        final user = UserModel.fromJson(userJson);
        return UserLogged(user);

      default:
        throw Exception('Unknown UserState type: $type');
    }
  }

  static UserState fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    switch (type) {
      case 'loading':
        return UserLoading();

      case 'unlogged':
        return UserUnlogged();

      case 'logged':
        final userJson = json['user'] as Map<String, dynamic>;
        final user = UserModel.fromJson(userJson);
        return UserLogged(user);

      default:
        throw Exception('Unknown UserState type: $type');
    }
  }

  static String key() => 'user_state';
}

class UserLoading extends UserState {}

class UserUnlogged extends UserState {}

class UserLogged extends UserState {
  final UserModel user;
  UserLogged(this.user);
}
