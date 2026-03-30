import 'package:redux/redux.dart';
import 'package:redux_example/features/todo/redux/action.dart';
import 'package:redux_example/features/todo/redux/state.dart';

final todoReducer = combineReducers<TodoState>([
  TypedReducer<TodoState, TodoCreateRequestAction>(_createRequest),
  TypedReducer<TodoState, TodoCreateSuccessAction>(_createSuccess),
  TypedReducer<TodoState, TodoCreateFailureAction>(_createFailure),
  TypedReducer<TodoState, TodoDeleteRequestAction>(_deleteRequest),
  TypedReducer<TodoState, TodoDeleteSuccessAction>(_deleteSuccess),
]);

TodoState _createRequest(TodoState state, TodoCreateRequestAction action) {
  return state.copyWith(isLoading: true, error: null);
}

TodoState _createSuccess(TodoState state, TodoCreateSuccessAction action) {
  return state.copyWith(
    todos: [...state.todos, action.todo],
    isLoading: false,
    error: null,
  );
}

TodoState _createFailure(TodoState state, TodoCreateFailureAction action) {
  return state.copyWith(
    error: action.message,
    isLoading: false,
  );
}

TodoState _deleteRequest(TodoState state, TodoDeleteRequestAction action) {
  return state.copyWith();
}

TodoState _deleteSuccess(TodoState state, TodoDeleteSuccessAction action) {
  return state.copyWith(
    todos: state.todos.where((item) => item.id != action.id).toList(),
  );
}
