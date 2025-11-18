import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/features/auth/presentation/auth_view.dart';
import 'package:redux_example/redux/app_store.dart';
import 'package:redux_example/theme/ui_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  // Инициализируем DI
  await registerDependencies();

  runApp(
    StoreProvider(
      store: store,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Redux demo',
      theme: theme,
      home: AuthView(),
    );
  }
}
