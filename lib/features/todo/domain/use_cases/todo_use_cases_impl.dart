import 'package:flutter/material.dart';
import 'package:redux_example/features/todo/domain/entity/todo_entity.dart';
import 'package:redux_example/features/todo/domain/repository/todo_repository.dart';
import 'package:redux_example/features/todo/domain/use_cases/todo_use_cases.dart';

final class TodoUseCasesImpl implements TodoUseCases {
  final TodoRepository repository;
  const TodoUseCasesImpl(this.repository);

  @override
  Future<TodoEntity> create(String title) async {
    return repository.create(title);
  }

  @override
  Future<void> delete(UniqueKey id) async {
    return repository.delete(id);
  }
}
