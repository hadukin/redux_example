import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redux_example/features/auth/presentation/auth_view.dart';
import 'package:redux_example/features/todo/presentation/todo_view.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthView();
      },
    ),
    GoRoute(
      path: '/todo',
      builder: (BuildContext context, GoRouterState state) {
        return const TodoView();
      },
    ),
  ],
);
