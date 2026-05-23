
import '../../../config/constants.dart';
import '../../../data/models/user_state.dart';
import '../../../data/repositories/auth/auth_repository_provider.dart';
import '../../../domain/models/user/user_model.dart';
import '../../../utils/enums/modules.dart';
import '../../../utils/extensions/context.dart';
import '../../../utils/result.dart';
import '../../auth/signin/widgets/signin_screen.dart';
import '../../core/localization/applocalization.dart';
import '../../users/widgets/users_screen.dart';
import '../view_models/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  final HomeViewmodel? viewmodel;
  const HomeScreen({super.key, this.viewmodel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewmodel _viewmodel;
  late AuthRepository authRepository;
  int selectedIndex = 0;

  UserModel get user => (authRepository.userState.value as UserLogged).user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.viewmodel != null) {
      _viewmodel = widget.viewmodel!;
    } else {
      authRepository = AuthRepositoryProvider.of(context);
      _viewmodel = HomeViewmodel(authRepository: authRepository);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: changeItem,
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: EdgeInsets.only(top: mediumSpacing),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).colorScheme.outline,
                  child: Text(
                    (authRepository.userState.value as UserLogged).user.name[0],
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () async {
                  final result = await _viewmodel.signOut();

                  if (!context.mounted) return;

                  if (result is Ok) {
                    Navigator.pushReplacementNamed(
                      context,
                      SigninScreen.routeName,
                    );
                  } else {
                    context.showSnackBar(
                      localization.unknownError,
                      isError: true,
                    );
                  }
                },
                icon: const Icon(Icons.exit_to_app),
              ),
              destinations: [
                const NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text("Dashboard"),
                ),
                if (user.hasPermission(Modules.users, read: true))
                  NavigationRailDestination(
                    label: Text(localization.moduleUsers),
                    icon: const Icon(Icons.people),
                  ),
                if (user.hasPermission(Modules.products, read: true))
                  NavigationRailDestination(
                    label: Text(localization.moduleProducts),
                    icon: const Icon(Icons.shopping_cart),
                  ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (selectedIndex == 1) {
                    return UsersScreen();
                  }
                  return const Placeholder();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
