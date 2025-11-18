import 'package:rxdart/transformers.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/features/todo/domain/use_cases/todo_use_cases.dart';
import 'package:redux_example/features/todo/redux/action.dart';
import 'package:redux_example/redux/app_store.dart';

final todoEpics = combineEpics<AppState>([
  TypedEpic<AppState, TodoCreateRequestAction>(_TodoCreateEpics(getIt.get())),
  TypedEpic<AppState, TodoDeleteRequestAction>(_TodoDeleteEpics(getIt.get())),
]);

class _TodoCreateEpics implements EpicClass<AppState> {
  final TodoUseCases cases;
  const _TodoCreateEpics(this.cases);

  @override
  Stream<TodoAction> call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<TodoCreateRequestAction>().asyncExpand((event) async* {
      if (event.title.isEmpty) {
        yield const TodoCreateFailureAction('The filed not must be empty');
      }
      try {
        final todo = await cases.create(event.title);

        if (event.title.isEmpty) {
          yield const TodoCreateFailureAction('The filed not must be empty');
        } else {
          yield TodoCreateSuccessAction(todo);
        }
      } catch (e) {
        yield const TodoCreateFailureAction('Something went wrong');
      }
    });
  }
}

class _TodoDeleteEpics implements EpicClass<AppState> {
  final TodoUseCases cases;
  const _TodoDeleteEpics(this.cases);

  @override
  Stream<TodoAction> call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<TodoDeleteRequestAction>().asyncExpand((event) async* {
      try {
        await cases.delete(event.id);

        yield TodoDeleteSuccessAction(event.id);
      } catch (e) {
        yield const TodoDeleteFailureAction();
      }
    });
  }
}
