import 'package:flutter/material.dart';

import 'user_repository.dart';

export 'user_repository.dart';

class UserRepositoryProvider extends InheritedWidget {
  const UserRepositoryProvider({super.key, required this.userRepository, required super.child});

  final UserRepository userRepository;

  static UserRepositoryProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserRepositoryProvider>();
  }

  static UserRepository of(BuildContext context) {
    final UserRepositoryProvider? result = maybeOf(context);
    assert(result != null, 'No UserRepository found in context');
    return result!.userRepository;
  }

  @override
  bool updateShouldNotify(UserRepositoryProvider oldWidget) => userRepository != oldWidget.userRepository;
}
