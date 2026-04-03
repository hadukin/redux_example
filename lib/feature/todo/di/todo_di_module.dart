import 'package:get_it/get_it.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/feature/todo/data/data_source/todo_remote_data_source.dart';
import 'package:redux_example/feature/todo/data/data_source/todo_remote_data_source_impl.dart';
import 'package:redux_example/feature/todo/data/repository/todo_repository_impl.dart';
import 'package:redux_example/feature/todo/domain/repository/todo_repository.dart';
import 'package:redux_example/feature/todo/domain/use_cases/todo_create_use_case.dart';
import 'package:redux_example/feature/todo/domain/use_cases/todo_delete_use_case.dart';

final class TodoDiModule implements DiModule {
  @override
  Future<void> register(GetIt instance) async {
    instance.registerSingleton<TodoRemoteDateSource>(TodoRemoteDateSourceImpl());
    instance.registerSingleton<TodoRepository>(TodoRepositoryImpl(instance.get()));
    instance.registerSingleton(TodoCreateUseCase(instance.get()));
    instance.registerSingleton(TodoDeleteUseCase(instance.get()));
  }
}
