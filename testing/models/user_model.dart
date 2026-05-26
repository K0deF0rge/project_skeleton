import 'package:project_skeleton/domain/models/base.dart';

class UserModel extends BaseModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }

  @override
  BaseModel toModel(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  static String getTableName() => 'users';
}

final kUserModel = UserModel(
  id: '1',
  name: 'User 1',
  email: 'user1@example.com',
);

final kUserModels = [
  UserModel(id: '2', name: 'User 2', email: 'user2@example.com'),
  UserModel(id: '3', name: 'User 3', email: 'user3@example.com'),
];