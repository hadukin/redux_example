import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/features/auth/presentation/auth_view.dart';
import 'package:redux_example/redux/app_store.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Redux demo',
      theme: ThemeData(useMaterial3: true),
      home: const AuthView(),
    );
  }
}
