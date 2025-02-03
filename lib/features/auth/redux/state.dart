import 'package:equatable/equatable.dart';
import 'package:redux_example/features/auth/domain/entity/user_entity.dart';

sealed class AuthState extends Equatable {
  final UserEntity? user;
  const AuthState([this.user]);
}

class UnauthorizedState extends AuthState {
  const UnauthorizedState();

  @override
  List<Object?> get props => [user];
}

final class AuthorizedState extends AuthState {
  @override
  final UserEntity user;

  const AuthorizedState({required this.user}) : super(user);

  @override
  List<Object?> get props => [user];
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState(super.user);

  @override
  List<Object?> get props => [user];
}

final class AuthFailureState extends AuthState {
  final String? message;
  const AuthFailureState([this.message]);

  @override
  List<Object?> get props => [message, user];
}
