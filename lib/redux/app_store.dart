import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_example/feature/auth/redux/epic.dart';
import 'package:redux_example/feature/todo/redux/epic.dart';
import 'package:redux_example/feature/auth/redux/action.dart';
import 'package:redux_example/feature/auth/redux/reducer.dart';
import 'package:redux_example/feature/todo/redux/reducer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux_example/feature/auth/redux/state.dart';
import 'package:redux_example/feature/todo/redux/state.dart';

part 'app_epic.dart';
part 'app_reducer.dart';
part 'app_state.dart';
part 'app_store.freezed.dart';

final Store<AppState> store = Store<AppState>(
  _appReducer,
  initialState: AppState(),
  middleware: [EpicMiddleware(_createAppEpic())],
  distinct: true,
);

extension BuildContextExtension on BuildContext {
  dynamic action(dynamic action) {
    StoreProvider.of<AppState>(this).dispatch(action);
  }
}
