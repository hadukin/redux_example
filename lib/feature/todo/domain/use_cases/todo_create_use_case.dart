import 'package:redux_example/feature/todo/domain/entity/todo_entity.dart';
import 'package:redux_example/feature/todo/domain/repository/todo_repository.dart';

class TodoCreateUseCase {
  final TodoRepository repository;
  const TodoCreateUseCase(this.repository);

  Future<TodoEntity> call(String title) async {
    return repository.create(title);
  }
}
