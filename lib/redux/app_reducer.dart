part of 'app_store.dart';

AppState _appReducer(AppState state, action) {
  if (action is SignOutSuccessAction) {
    return AppState();
  }

  return AppState(
    todo: todoReducer(state.todo, action),
    auth: authReducer(state.auth, action),
  );
}
