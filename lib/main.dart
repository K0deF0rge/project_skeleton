import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/model/user_state.dart';
import 'data/repositories/auth/auth_repository_remote.dart';
import 'data/services/api/supabase/auth_service.dart';
import 'data/services/local/local_service.dart';
import 'data/services/local/shared_preferences.dart';
import 'my_app.dart';
import 'data/repositories/user/user_repository_remote.dart';
import 'data/services/api/supabase/api_service.dart';
import 'domain/models/user/user.dart';
import 'utils/extensions/context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );
  sharedPreferences = await SharedPreferences.getInstance();
  final supabase = Supabase.instance.client;

  runApp(
    MyApp(
      authRepository: AuthRepositoryRemote(
        authService: AuthService(supabase: supabase),
        localService: LocalService<UserState>(
          UserState.key(),
          toModel: UserState.fromJson,
        ),
      ),
      userRepository: UserRepositoryRemote(
        apiService: APIService<UserModel>(
          supabase: supabase,
          tableName: UserModel.getTableName(),
          fromJson: UserModel.fromJson,
        ),
      ),
    ),
  );
}
