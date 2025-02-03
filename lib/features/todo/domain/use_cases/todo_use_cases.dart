import 'package:flutter/material.dart';
import 'package:redux_example/features/todo/domain/entity/todo_entity.dart';

abstract interface class TodoUseCases {
  Future<TodoEntity> create(String title);
  Future<void> delete(UniqueKey id);
}
