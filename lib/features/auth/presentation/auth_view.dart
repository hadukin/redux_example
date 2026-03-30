import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(
      LoginRequestAction(
        email: _controller.text,
        password: 'password',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: StoreConnector<AppState, AuthState>(
                    distinct: true,
                    onDidChange: (previousViewModel, viewModel) {
                      if (viewModel is AuthorizedState) {
                        context.go('/todo');
                      }
                    },
                    converter: (store) => store.state.auth,
                    builder: (context, state) {
                      final bool isLoading = state is AuthLoadingState;
                      final String? errorText = switch (state) {
                        AuthFailureState(:final message) => message,
                        _ => null,
                      };

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Добро пожаловать!',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Авторизуйтесь, чтобы управлять своими напоминаниями.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          TextField(
                            controller: _controller,
                            enabled: !isLoading,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: errorText == null
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                      errorText,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Theme.of(context).colorScheme.error,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 32),
                          FilledButton.icon(
                            icon: isLoading
                                ? SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  )
                                : const Icon(Icons.login_rounded),
                            label: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(isLoading ? 'Входим...' : 'Войти'),
                            ),
                            onPressed: switch (state) {
                              UnauthorizedState _ || AuthFailureState _ => () => _onLogin(context),
                              _ => isLoading ? null : null,
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
