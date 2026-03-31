import 'package:redux_example/features/todo/domain/use_cases/todo_create_use_case.dart';
import 'package:redux_example/features/todo/domain/use_cases/todo_delete_use_case.dart';
import 'package:rxdart/transformers.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/features/todo/redux/action.dart';
import 'package:redux_example/redux/app_store.dart';

final todoEpics = combineEpics<AppState>([
  TypedEpic<AppState, TodoCreateRequestAction>(_TodoCreateEpics(getIt.get())),
  TypedEpic<AppState, TodoDeleteRequestAction>(_TodoDeleteEpics(getIt.get())),
]);

class _TodoCreateEpics implements EpicClass<AppState> {
  final TodoCreateUseCase todoCreateUseCase;
  const _TodoCreateEpics(this.todoCreateUseCase);

  @override
  Stream<TodoAction> call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<TodoCreateRequestAction>().asyncExpand((event) async* {
      if (event.title.isEmpty) {
        yield const TodoCreateFailureAction('The filed not must be empty');
      }
      try {
        final todo = await todoCreateUseCase(event.title);
        yield TodoCreateSuccessAction(todo);
      } catch (e) {
        yield const TodoCreateFailureAction('Something went wrong');
      }
    });
  }
}

class _TodoDeleteEpics implements EpicClass<AppState> {
  final TodoDeleteUseCase todoDeleteUseCase;
  const _TodoDeleteEpics(this.todoDeleteUseCase);

  @override
  Stream<TodoAction> call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<TodoDeleteRequestAction>().asyncExpand((event) async* {
      try {
        await todoDeleteUseCase(event.id);

        yield TodoDeleteSuccessAction(event.id);
      } catch (e) {
        yield const TodoDeleteFailureAction();
      }
    });
  }
}
