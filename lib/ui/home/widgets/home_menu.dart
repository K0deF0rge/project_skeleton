import '../../../config/constants.dart';
import '../../../data/model/user_state.dart';
import '../../../domain/models/user/user.dart';
import '../../../utils/enums/modules.dart';
import '../../../utils/extensions/context.dart';
import '../../users/widgets/users_screen.dart';
import '../view_models/home_viewmodel.dart';
import '../view_models/home_viewmodel_provider.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late HomeViewmodel viewmodel;

  UserModel get user =>
      (viewmodel.authRepository.userState.value as UserLogged).user;

  @override
  Widget build(BuildContext context) {
    viewmodel = HomeViewmodelProvider.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            stretch: true,
            expandedHeight: 60.0,
            title: Text('Configurações'),
          ),
          SliverPadding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: smallSpacing,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (user.hasPermission(Modules.users, read: true))
                  OptionTile(
                    title: 'Usuários',
                    onTap: () =>
                        Navigator.pushNamed(context, UsersScreen.routeName),
                  ),
                if (user.hasPermission(Modules.products, read: true))
                  OptionTile(title: Modules.products.title),
                const OptionTile(title: 'Assinaturas'),
                OptionTile(title: 'Sair', onTap: viewmodel.signOut),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const OptionTile({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 10.0),
    );
  }
}
