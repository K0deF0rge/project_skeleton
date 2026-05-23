import 'package:flutter/material.dart';

import 'data/repositories/auth/auth_repository_dev.dart';
import 'data/repositories/role/role_repository_dev.dart';
import 'data/repositories/user/user_repository_dev.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    authRepository: AuthRepositoryDev(),
    userRepository: UserRepositoryDev(service: null),
    roleRepository: RoleRepositoryDev(),
  ));
}