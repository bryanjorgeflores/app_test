import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_test/app/features/auth/presentation/pages/login/login_page.dart';
import 'package:app_test/app/features/auth/presentation/pages/register/register_page.dart';
import 'package:app_test/app/features/home_tabs/home_tabs_page.dart';
import 'package:app_test/app/features/task_edit/presentation/task_edit_page.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.cache.user != null) {
                return const HomeTabsPage();
              }
              return const LoginPage();
            },
          ),
        );

      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeTabsPage(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      case '/register':
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );

      case '/task-edit':
        return MaterialPageRoute(
          builder: (context) => TaskEditPage(
            task: settings.arguments as TodoTask?,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
