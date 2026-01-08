import 'package:flutter/material.dart';

import '../../../core/logger.dart';
import '../../../data/repositories/user/user_repository_provider.dart';
import '../../../domain/models/user/user.dart';
import '../../../utils/command_builder.dart';
import '../../../utils/result.dart';
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
    AppLogger.debug(
      'Building UsersScreen with ${_viewmodel.userRepository.runtimeType}',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Usuários')),
      body: Center(
        child: CommandBuilder(
          command: _viewmodel.getUsers,
          initialWidget: const CircularProgressIndicator(),
          onRunning: (_) => const CircularProgressIndicator(),
          onCompleted: (_) {
            final users =
                (_viewmodel.getUsers.result as Ok<List<UserModel>>).value;
                
            if (users.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.hourglass_empty),
                  const Text('Sem usuários'),
                  ElevatedButton(
                    onPressed: () {
                      _viewmodel.getUsers.execute();
                    },
                    child: const Text('Tentar novamente'),
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
