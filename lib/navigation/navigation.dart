import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_heroes/features/heroes/heroes.dart';

enum RoutePath {
  home('/'),
  heroDetails('/hero-details');

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
      GoRoute(
        path: RoutePath.heroDetails.value,
        pageBuilder: (context, state) {
          final heroModel = state.extra as HeroModel;
          return CustomTransitionPage(
            opaque: false,
            barrierDismissible: true,
            child: HeroDetailsPage(heroModel: heroModel),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}
