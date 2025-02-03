import 'package:redux/redux.dart';
import 'package:redux_example/features/auth/redux/action.dart';
import 'package:redux_example/features/auth/redux/state.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LoginRequestAction>(_loginRequest),
  TypedReducer<AuthState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<AuthState, LoginFailureAction>(_loginFailure),
  TypedReducer<AuthState, SignOutRequestAction>(_signOutRequest),
  TypedReducer<AuthState, SignOutSuccessAction>(_signOutSuccess),
]);

AuthState _loginRequest(AuthState state, LoginRequestAction action) {
  return AuthLoadingState(state.user);
}

AuthState _loginSuccess(AuthState state, LoginSuccessAction action) {
  return AuthorizedState(user: action.user);
}

AuthState _loginFailure(AuthState state, LoginFailureAction action) {
  return AuthFailureState(action.message);
}

AuthState _signOutRequest(AuthState state, SignOutRequestAction action) {
  return AuthLoadingState(state.user);
}

AuthState _signOutSuccess(AuthState state, SignOutSuccessAction action) {
  return UnauthorizedState();
}
