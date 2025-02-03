import 'package:flutter/material.dart';
import 'package:redux_example/features/todo/data/data_source/todo_remote_data_source.dart';
import 'package:redux_example/features/todo/domain/entity/todo_entity.dart';
import 'package:redux_example/features/todo/domain/repository/todo_repository.dart';

final class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDateSource remoteDateSource;
  const TodoRepositoryImpl(this.remoteDateSource);

  @override
  Future<TodoEntity> create(String title) {
    return remoteDateSource.create(title);
  }

  @override
  Future<void> delete(UniqueKey id) {
    return remoteDateSource.delete(id);
  }
}
