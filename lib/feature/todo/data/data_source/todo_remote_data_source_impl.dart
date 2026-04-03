import 'package:flutter/foundation.dart';
import 'package:redux_example/feature/todo/data/data_source/todo_remote_data_source.dart';
import 'package:redux_example/feature/todo/domain/entity/todo_entity.dart';

final class TodoRemoteDateSourceImpl implements TodoRemoteDateSource {
  @override
  Future<TodoEntity> create(String title) async {
    final id = await Future.delayed(const Duration(seconds: 1), () => UniqueKey());
    return TodoEntity(id: id, title: title);
  }

  @override
  Future<void> delete(UniqueKey id) async {}
}
