import 'package:flutter/material.dart';
import 'package:redux_example/feature/todo/domain/entity/todo_entity.dart';

abstract interface class TodoRemoteDateSource {
  Future<TodoEntity> create(String title);
  Future<void> delete(UniqueKey id);
}
