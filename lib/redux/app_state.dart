part of 'app_store.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(UnauthorizedState()) AuthState auth,
    @Default(TodoState()) TodoState todo,
  }) = _AppState;
}
