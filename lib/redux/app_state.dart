import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux_example/features/auth/redux/state.dart';
import 'package:redux_example/features/todo/redux/state.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(UnauthorizedState()) AuthState auth,
    @Default(TodoState()) TodoState todo,
  }) = _AppState;
}
