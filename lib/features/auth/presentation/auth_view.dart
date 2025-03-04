import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/features/auth/redux/action.dart';
import 'package:redux_example/features/auth/redux/state.dart';
import 'package:redux_example/redux/app_store.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StoreConnector<AppState, AuthState>(
                distinct: true,
                converter: (store) => store.state.auth,
                builder: (context, state) {
                  return switch (state) {
                    AuthLoadingState _ => const CircularProgressIndicator(),
                    _ => SizedBox.shrink(),
                  };
                },
              ),
              StoreConnector<AppState, AuthState>(
                distinct: true,
                converter: (store) => store.state.auth,
                builder: (context, state) {
                  return TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: switch (state) {
                        AuthFailureState(:final message) => message,
                        _ => null,
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.maxFinite,
                child: StoreConnector<AppState, AuthState>(
                  distinct: true,
                  converter: (store) => store.state.auth,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: switch (state) {
                        UnauthorizedState _ || AuthFailureState _ => () {
                            StoreProvider.of<AppState>(context).dispatch(
                              LoginRequestAction(
                                email: _controller.text,
                                password: 'password',
                              ),
                            );
                          },
                        _ => null
                      },
                      child: const Text('Login'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
