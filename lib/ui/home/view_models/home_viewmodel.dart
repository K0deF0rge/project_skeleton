
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../../utils/result.dart';

class HomeViewmodel {
  HomeViewmodel({required this.authRepository});

  final AuthRepository authRepository;

  FutureResultVoid signOut() async {
    return await authRepository.signOut();
  }
}
