import 'package:flutter/material.dart';
import 'package:redux_example/feature/todo/domain/entity/todo_entity.dart';

sealed class TodoAction {
  const TodoAction();
}

final class TodoCreateRequestAction extends TodoAction {
  final String title;
  TodoCreateRequestAction(this.title);
}

final class TodoCreateSuccessAction extends TodoAction {
  final TodoEntity todo;

  const TodoCreateSuccessAction(this.todo);
}

final class TodoCreateFailureAction extends TodoAction {
  final String message;
  const TodoCreateFailureAction(this.message);
}

final class TodoDeleteRequestAction extends TodoAction {
  final UniqueKey id;
  const TodoDeleteRequestAction(this.id);
}

final class TodoDeleteSuccessAction extends TodoAction {
  final UniqueKey id;
  const TodoDeleteSuccessAction(this.id);
}

final class TodoDeleteFailureAction extends TodoAction {
  const TodoDeleteFailureAction();
}
