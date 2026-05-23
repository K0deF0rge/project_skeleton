import 'package:flutter/material.dart';

import '../../../domain/repositories/role/role_repository.dart';

export '../../../domain/repositories/role/role_repository.dart';

class RoleRepositoryProvider extends InheritedWidget {
  const RoleRepositoryProvider({super.key, required this.roleRepository, required super.child});

  final RoleRepository roleRepository;

  static RoleRepositoryProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RoleRepositoryProvider>();
  }

  static RoleRepository of(BuildContext context) {
    final RoleRepositoryProvider? result = maybeOf(context);
    assert(result != null, 'No RoleRepository found in context');
    return result!.roleRepository;
  }

  @override
  bool updateShouldNotify(RoleRepositoryProvider oldWidget) => roleRepository != oldWidget.roleRepository;
}
