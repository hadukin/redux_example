import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/redux/app_store.dart';
import 'package:redux_example/router/router.dart';

Future<void> main() async {
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
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
