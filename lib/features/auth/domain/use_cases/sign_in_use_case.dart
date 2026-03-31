import 'package:redux_example/features/auth/domain/entity/user_entity.dart';
import 'package:redux_example/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  const SignInUseCase(this.repository);

  Future<UserEntity> call(String name) => repository.signIn(name);
}
