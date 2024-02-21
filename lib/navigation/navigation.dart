import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_heroes/features/heroes/heroes.dart';


enum RoutePath {
  home('/');

  const RoutePath(this.value);

  final String value;
}

class Routes {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: RoutePath.home.value,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HeroesPage(),
        ),
      ),
    ],
  );
}
