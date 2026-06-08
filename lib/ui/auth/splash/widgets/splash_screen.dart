import 'package:flutter/material.dart';

import '../../../../data/repositories/auth/auth_repository_provider.dart';
import '../view_models/splash_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  final SplashViewmodel? viewmodel;
  static String routeName = "/splash";
  const SplashScreen({this.viewmodel, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewmodel viewmodel;
  bool _didInitDependencies = false;

  @override
  void initState() {
    super.initState();
    if (widget.viewmodel != null) {
      viewmodel = widget.viewmodel!;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInitDependencies) {
      if (widget.viewmodel == null) {
        viewmodel = SplashViewmodel(authRepository: AuthRepositoryProvider.of(context));
      }
      _didInitDependencies = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Icon(Icons.ac_unit_rounded, size: 100.0))),
    );
  }
}
