import 'package:flutter/material.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/features/auth/domain/repository/auth_repository.dart';
import 'package:redux_example/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:redux_example/features/auth/redux/action.dart';
import 'package:redux_example/main.dart';
import 'package:redux_example/features/auth/presentation/auth_view.dart';
import 'package:redux_example/features/todo/presentation/todo_view.dart';
import 'package:redux_example/redux/app_state.dart';
import 'package:rxdart/transformers.dart';

final authEpics = combineEpics<AppState>([
  TypedEpic<AppState, LoginRequestAction>(_LoginEpic(authUseCases: getIt.get())),
  TypedEpic<AppState, SignOutRequestAction>(_SignOutEpic(authUseCases: getIt.get())),
]);

class _LoginEpic implements EpicClass<AppState> {
  final AuthUseCases _authUseCases;

  const _LoginEpic({
    required AuthUseCases authUseCases,
  }) : _authUseCases = authUseCases;

  @override
  Stream<AuthAction> call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<LoginRequestAction>().asyncExpand((event) async* {
      if (event.email.isEmpty) {
        yield const LoginFailureAction(message: 'Введите email');
        return;
      }

      try {
        final user = await _authUseCases.signIn(event.email);

        navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const TodoView();
          },
        ));

        yield LoginSuccessAction(user: user);
      } catch (e) {
        yield LoginFailureAction(message: e.toString());
      }
    });
  }
}

class _SignOutEpic implements EpicClass<AppState> {
  final AuthRepository _authUseCases;

  const _SignOutEpic({
    required AuthRepository authUseCases,
  }) : _authUseCases = authUseCases;

  @override
  Stream<AuthAction> call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<SignOutRequestAction>().asyncExpand((event) async* {
      await _authUseCases.signOut();
      navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const AuthView();
        },
      ));
      yield const SignOutSuccessAction();
    });
  }
}
