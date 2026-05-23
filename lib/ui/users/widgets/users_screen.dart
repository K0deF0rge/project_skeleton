import 'package:flutter/material.dart';

import '../../../data/repositories/user/user_repository_provider.dart';
import '../../../domain/models/user/user_model.dart';
import '../../../utils/command_builder.dart';
import '../../core/localization/applocalization.dart';
import '../view_models/users_viewmodel.dart';

class UsersScreen extends StatefulWidget {
  static String routeName = "/users";

  const UsersScreen({super.key, this.viewmodel});
  final UsersViewmodel? viewmodel;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UsersViewmodel _viewmodel;
  late AppLocalization localization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.viewmodel != null) {
      _viewmodel = widget.viewmodel!;
    } else {
      final userRepository = UserRepositoryProvider.of(context);
      _viewmodel = UsersViewmodel(userRepository: userRepository);
    }
  }

  @override
  Widget build(BuildContext context) {
    localization = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localization.usersTitle)),
      body: SafeArea(
        child: Command0BuilderList<UserModel>(
          command: _viewmodel.getUsers,
          initialWidget: const CircularProgressIndicator(),
          onRunning: (_) => const CircularProgressIndicator(),
          onCompleted: (_, users) {
            if (users.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.hourglass_empty),
                  Text(localization.usersEmptyState),
                  ElevatedButton(
                    onPressed: () {
                      _viewmodel.getUsers.execute();
                    },
                    child: Text(localization.retryButton),
                  ),
                ],
              );
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
