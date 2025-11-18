import 'package:get_it/get_it.dart';
import 'package:redux_example/features/auth/di/auth_di_module.dart';
import 'package:redux_example/features/todo/di/todo_di_module.dart';

GetIt getIt = GetIt.instance;

abstract interface class DiModule {
  Future<void> register(GetIt instance);
}

extension GetItExtension on GetIt {
  Future<void> registerModule(DiModule module) => module.register(this);
}

Future registerDependencies() async {
  // Регистрируем модули фич
  await getIt.registerModule(AuthDiModule());
  await getIt.registerModule(TodoDiModule());
  // ... другие модули
}
