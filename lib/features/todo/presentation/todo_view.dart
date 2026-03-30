import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:redux_example/features/auth/redux/action.dart';
import 'package:redux_example/features/auth/redux/state.dart';
import 'package:redux_example/redux/app_store.dart';
import 'package:redux_example/features/todo/redux/action.dart';
import 'package:redux_example/features/todo/redux/state.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Мои напоминания'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _buildUserAvatar(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Создайте новое напоминание',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: 'Описание задачи',
                                prefixIcon: Icon(Icons.edit_outlined),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          StoreConnector<AppState, bool>(
                            distinct: true,
                            converter: (store) => store.state.todo.isLoading,
                            builder: (context, isLoading) {
                              return FilledButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        store.dispatch(TodoCreateRequestAction(controller.text.trim()));
                                        controller.clear();
                                      },
                                child: isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(strokeWidth: 3),
                                      )
                                    : const Icon(Icons.add_rounded),
                              );
                            },
                          ),
                        ],
                      ),
                      StoreConnector<AppState, String?>(
                        distinct: true,
                        converter: (store) => store.state.todo.error,
                        builder: (context, errorMessage) {
                          if (errorMessage == null) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              errorMessage,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(child: _buildListTodo()),
              const SizedBox(height: 12),
              _buildSignOutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTodo() {
    return StoreConnector<AppState, TodoState>(
      distinct: true,
      converter: (store) => store.state.todo,
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return Center(
            child: Text(
              'Пока нет напоминаний.\nДобавьте первое!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 8),
          itemCount: state.todos.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = state.todos[index];

            return Card(
              child: ListTile(
                title: Text(
                  item.title,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(
                      TodoDeleteRequestAction(item.id),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUserAvatar() {
    return StoreConnector<AppState, AuthState>(
      converter: (store) => store.state.auth,
      distinct: true,
      builder: (context, state) {
        return switch (state) {
          AuthorizedState(:final user) => CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                user.email.characters.first.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          AuthLoadingState(:final user) => CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                (user?.email.characters.first ?? '…').toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildSignOutButton() {
    return StoreConnector<AppState, AuthState>(
      onDidChange: (previousViewModel, viewModel) {
        if (viewModel is UnauthorizedState) {
          context.go('/');
        }
      },
      converter: (store) => store.state.auth,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: switch (state) {
              AuthLoadingState _ => const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              _ => const Icon(Icons.logout_rounded),
            },
            label: Text(state is AuthLoadingState ? '' : 'Выйти'),
            onPressed: state is AuthLoadingState
                ? null
                : () {
                    StoreProvider.of<AppState>(context).dispatch(const SignOutRequestAction());
                  },
          ),
        );
      },
    );
  }
}
