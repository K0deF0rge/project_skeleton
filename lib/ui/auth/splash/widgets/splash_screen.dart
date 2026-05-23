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
  late AuthRepository authRepository;
  // late SplashViewmodel _viewmodel;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      authRepository = AuthRepositoryProvider.of(context);
      // _viewmodel = widget.viewmodel ?? SplashViewmodel(authRepository: authRepository);
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Icon(Icons.ac_unit_rounded, size: 100.0))),
    );
  }
}
