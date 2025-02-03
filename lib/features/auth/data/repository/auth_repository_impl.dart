import 'package:redux_example/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:redux_example/features/auth/domain/entity/user_entity.dart';
import 'package:redux_example/features/auth/domain/repository/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  const AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity> signIn(String name) {
    return dataSource.signIn(name);
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }
}
