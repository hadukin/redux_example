import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: StoreConnector<AppState, AuthState>(
          converter: (store) => store.state.auth,
          builder: (context, state) {
            return switch (state) {
              AuthorizedState(:final user) => Text(
                  'Email: ${user.email}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              AuthLoadingState(:final user) => Text(
                  'Email: ${user?.email}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              _ => SizedBox.shrink(),
            };
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: TextField(controller: controller)),
                IconButton(
                  onPressed: () {
                    store.dispatch(TodoCreateRequestAction(controller.text));
                    controller.text = '';
                  },
                  icon: StoreConnector<AppState, bool>(
                    distinct: true,
                    converter: (store) => store.state.todo.isLoading,
                    builder: (context, isLoadingTodo) {
                      return isLoadingTodo
                          ? const RepaintBoundary(child: CircularProgressIndicator())
                          : const Icon(Icons.add);
                    },
                  ),
                )
              ],
            ),
          ),
          StoreConnector<AppState, String?>(
            distinct: true,
            converter: (store) => store.state.todo.error,
            builder: (context, errorMessage) {
              if (errorMessage != null) {
                return Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            flex: 3,
            child: StoreConnector<AppState, TodoState>(
              distinct: true,
              converter: (store) => store.state.todo,
              builder: (context, state) {
                return ListView(
                  children: [
                    for (final item in state.todos)
                      ListTile(
                        title: Text(item.title),
                        trailing: IconButton(
                          icon: state.deleteId == item.id
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Icon(Icons.delete),
                          onPressed: () {
                            StoreProvider.of<AppState>(context).dispatch(
                              TodoDeleteRequestAction(item.id),
                            );
                          },
                        ),
                      )
                  ],
                );
              },
            ),
          ),
          const Spacer(),
          StoreConnector<AppState, AuthState>(
            converter: (store) => store.state.auth,
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(16),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(const SignOutRequestAction());
                  },
                  child: switch (state) {
                    AuthLoadingState _ => const CircularProgressIndicator(),
                    _ => const Text('Sign out'),
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
