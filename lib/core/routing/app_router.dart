import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/routing/routes.dart';
import 'package:pulse/features/auth/presentation/ui/auth_startup_screen.dart';
import 'package:pulse/features/auth/presentation/ui/forget_password_screen.dart';
import 'package:pulse/features/auth/presentation/ui/login_screen.dart';
import 'package:pulse/features/auth/presentation/ui/register_screen.dart';
import 'package:pulse/features/chat/data/user_model.dart';
import 'package:pulse/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:pulse/features/chat/presentation/ui/blocked_users_screen.dart';
import 'package:pulse/features/chat/presentation/ui/chat_room_screen.dart';
import 'package:pulse/features/chat/presentation/ui/chats_screen.dart';
import 'package:pulse/features/chat/presentation/ui/settings_screen.dart';
import 'package:pulse/features/theme/presentation/ui/theme_startup_screen.dart';

import '../di/dependency_injection.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.themeStartupScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const ThemeStartupScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case Routes.authStartupScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const AuthStartupScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case Routes.loginScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case Routes.registerScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const RegisterScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case Routes.chatsScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BlocProvider.value(
            value: getIt<ChatCubit>(),
            child: const ChatsScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case Routes.chatRoomScreen:
        final receiverUser = settings.arguments as UserModel;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BlocProvider.value(
            value: getIt<ChatCubit>(),
            child: ChatRoomScreen(
              receiverUser: receiverUser,
            ),
          ),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case Routes.forgetPasswordScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const ForgetPasswordScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case Routes.settingsScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const SettingsScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case Routes.blockedUsersScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const BlockedUsersScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

  Route _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text(message)),
      ),
    );
  }
}
