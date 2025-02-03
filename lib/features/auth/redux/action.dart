import 'package:redux_example/features/auth/domain/entity/user_entity.dart';

sealed class AuthAction {
  const AuthAction();
}

final class LoginRequestAction extends AuthAction {
  final String email;
  final String password;

  const LoginRequestAction({
    required this.email,
    required this.password,
  });
}

final class LoginSuccessAction extends AuthAction {
  final UserEntity user;

  const LoginSuccessAction({required this.user});
}

final class LoginFailureAction extends AuthAction {
  final String message;

  const LoginFailureAction({required this.message});
}

final class SignOutRequestAction extends AuthAction {
  const SignOutRequestAction();
}

final class SignOutSuccessAction extends AuthAction {
  const SignOutSuccessAction();
}
