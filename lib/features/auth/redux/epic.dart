import 'package:redux_epics/redux_epics.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:redux_example/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:redux_example/features/auth/redux/action.dart';
import 'package:redux_example/redux/app_store.dart';
import 'package:rxdart/transformers.dart';

final authEpics = combineEpics<AppState>([
  TypedEpic<AppState, LoginRequestAction>(_LoginEpic(signInUseCase: getIt.get())),
  TypedEpic<AppState, SignOutRequestAction>(_SignOutEpic(signOutUseCase: getIt.get())),
]);

class _LoginEpic implements EpicClass<AppState> {
  final SignInUseCase _signInUseCase;

  const _LoginEpic({
    required SignInUseCase signInUseCase,
  }) : _signInUseCase = signInUseCase;

  @override
  Stream<AuthAction> call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<LoginRequestAction>().asyncExpand((event) async* {
      if (event.email.isEmpty) {
        yield const LoginFailureAction(message: 'Введите email');
        return;
      }

      try {
        final user = await _signInUseCase(event.email);
        yield LoginSuccessAction(user: user);
      } catch (e) {
        yield LoginFailureAction(message: e.toString());
      }
    });
  }
}

class _SignOutEpic implements EpicClass<AppState> {
  final SignOutUseCase _signOutUseCase;

  const _SignOutEpic({
    required SignOutUseCase signOutUseCase,
  }) : _signOutUseCase = signOutUseCase;

  @override
  Stream<AuthAction> call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<SignOutRequestAction>().asyncExpand((event) async* {
      await _signOutUseCase();
      yield const SignOutSuccessAction();
    });
  }
}
