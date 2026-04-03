import 'package:redux_example/feature/auth/domain/entity/user_entity.dart';

abstract interface class AuthRepository {
  Future<UserEntity> signIn(String name);
  Future<void> signOut();
}
