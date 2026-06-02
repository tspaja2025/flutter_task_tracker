import 'package:flutter_task_tracker/screens/auth_screen.dart';
import 'package:flutter_task_tracker/screens/dashboard_screen.dart';
import 'package:flutter_task_tracker/shared/app_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: "auth",
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: "/dashboard",
            name: "dashboard",
            builder: (context, state) => const DashboardScreen(),
          ),
        ],
      ),
    ],
  );
});
