import 'package:chat_test_flutter/route/named.dart';
import 'package:chat_test_flutter/screens/auth/login_screen.dart';
import 'package:chat_test_flutter/screens/error_screen.dart';
import 'package:chat_test_flutter/screens/home_screen.dart';
import 'package:chat_test_flutter/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: root,
        builder: (context, state) => SplashScreen(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/home',
        name: home,
        builder: (context, state) => HomeScreen(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/login',
        name: login,
        builder: (context, state) => LoginScreen(
          key: state.pageKey,
        ),
      ),
    ],
    errorBuilder: (context, state) => RouteErrorScreen(
      errorMsg: state.error.toString(),
      key: state.pageKey,
    ),
  );
});
