import 'package:redux_example/features/auth/domain/entity/user_entity.dart';
import 'package:redux_example/features/auth/domain/repository/auth_repository.dart';
import 'package:redux_example/features/auth/domain/use_cases/auth_use_cases.dart';

final class AuthUseCasesImpl implements AuthUseCases {
  final AuthRepository repository;
  const AuthUseCasesImpl(this.repository);

  @override
  Future<UserEntity> signIn(String name) {
    return repository.signIn(name);
  }

  @override
  Future<void> signOut() {
    return repository.signOut();
  }
}
