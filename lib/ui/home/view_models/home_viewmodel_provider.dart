import 'package:flutter/material.dart';

import 'home_viewmodel.dart';

class HomeViewmodelProvider extends InheritedWidget {
  const HomeViewmodelProvider({super.key, required this.viewmodel, required super.child});

  final HomeViewmodel viewmodel;

  static HomeViewmodelProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeViewmodelProvider>();
  }

  static HomeViewmodel of(BuildContext context) {
    final HomeViewmodelProvider? result = maybeOf(context);
    assert(result != null, 'No HomeViewmodel found in context');
    return result!.viewmodel;
  }

  @override
  bool updateShouldNotify(HomeViewmodelProvider oldWidget) => viewmodel != oldWidget.viewmodel;
}
