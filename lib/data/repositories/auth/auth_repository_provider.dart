import 'package:flutter/material.dart';

import 'auth_repository.dart';

export 'auth_repository.dart';

class AuthRepositoryProvider extends InheritedWidget {
  const AuthRepositoryProvider({super.key, required this.authRepository, required super.child});

  final AuthRepository authRepository;

  static AuthRepositoryProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthRepositoryProvider>();
  }

  static AuthRepository of(BuildContext context) {
    final AuthRepositoryProvider? result = maybeOf(context);
    assert(result != null, 'No AuthRepository found in context');
    return result!.authRepository;
  }

  @override
  bool updateShouldNotify(AuthRepositoryProvider oldWidget) => authRepository != oldWidget.authRepository;
}