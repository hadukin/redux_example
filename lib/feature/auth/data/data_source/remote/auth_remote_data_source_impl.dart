import 'package:redux_example/feature/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:redux_example/feature/auth/domain/entity/user_entity.dart';

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserEntity> signIn(String name) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => UserEntity(email: name, name: name),
    );
  }

  @override
  Future<void> signOut() async {
    return Future.delayed(const Duration(seconds: 1));
  }
}
