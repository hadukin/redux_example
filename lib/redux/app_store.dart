import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_example/redux/app_state.dart';
import 'package:redux_example/features/auth/redux/epic.dart';
import 'package:redux_example/features/todo/redux/epic.dart';
import 'package:redux_example/features/auth/redux/action.dart';
import 'package:redux_example/features/auth/redux/reducer.dart';
import 'package:redux_example/features/todo/redux/reducer.dart';

part 'app_epic.dart';
part 'app_reducer.dart';

final Store<AppState> store = Store<AppState>(
  _appReducer,
  initialState: AppState(),
  middleware: [EpicMiddleware(_createAppEpic())],
  distinct: true,
);
