import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import '../../../core/logger.dart';
import '../../../data/model/user_state.dart';
import '../../../data/repositories/auth/auth_repository_provider.dart';
import '../view_models/home_viewmodel.dart';
import '../view_models/home_viewmodel_provider.dart';
import 'home_menu.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewmodel _viewmodel;
  int _currentIndex = 0;
  bool _viewmodelInitialized = false;

  BottomNavigationBarItem _itemToBnbi(Item item) =>
      BottomNavigationBarItem(label: item.label, icon: item.icon);

  void _changeItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Item> _items = [
    const Item(
      label: "Dashboard",
      icon: Icon(Icons.dashboard),
      widget: DashboardScreen(),
    ),
    const Item(label: "Menu", icon: Icon(Icons.menu), widget: Menu()),
  ];

  Widget get currentBody => _items[_currentIndex].widget;
  List<BottomNavigationBarItem> get items => _items.map(_itemToBnbi).toList();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_viewmodelInitialized) {
      final authRepository = AuthRepositoryProvider.of(context);
      _viewmodel = HomeViewmodel(authRepository: authRepository);
      _viewmodelInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.debug('Building HomeScreen');

    return HomeViewmodelProvider(
      viewmodel: _viewmodel,
      child: Scaffold(
        body: currentBody,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          onTap: _changeItem,
          items: items,
        ),
      ),
    );
  }
}

class Item {
  final String label;
  final Icon icon;
  final Widget widget;

  const Item({required this.label, required this.icon, required this.widget});
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.outline,
            child: Text(
              (authRepository.userState.value as UserLogged).user.name[0],
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.all(smallSpacing),
      ),
      body: const Placeholder(),
    );
  }
}
