import 'package:flutter/material.dart';
import 'package:redux_example/features/todo/domain/repository/todo_repository.dart';

class TodoDeleteUseCase {
  final TodoRepository repository;
  const TodoDeleteUseCase(this.repository);

  Future<void> call(UniqueKey id) async {
    return repository.delete(id);
  }
}
