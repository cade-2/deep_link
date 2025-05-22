import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hotlist/detail_view.dart';
import 'package:hotlist/home.dart';
import 'package:hotlist/splash.dart';

final goRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const HomePage(),
      ),
      routes: [
        GoRoute(
          path: 'blog/:id',
          name: 'blog',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return MaterialPage<void>(
              key: state.pageKey,
              child: DetailPage(id: id),
            );
          },
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    // Handle deep links here
    final uri = state.uri;
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'blog') {
      final id = uri.pathSegments.length > 1 ? uri.pathSegments[1] : '';
      return '/home/blog/$id';
    }
    return null;
  },
);
