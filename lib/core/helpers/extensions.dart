import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  /// Navigates to a new screen using a custom [PageRouteBuilder] with a fade transition.
  void navigateTo(Widget route) {
    Navigator.push(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondAnimation) => route,
        transitionsBuilder: (context, animation, secondAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  /// Navigates to a named route.
  /// Optionally, pass [arguments] to the route.
  void navigateToNamed(String routeName, {Object? arguments}) {
    Navigator.pushNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  /// Replaces the current screen with a new screen using a custom [PageRouteBuilder]
  /// with a fade transition.
  void navigateToReplacement(Widget route) {
    Navigator.pushReplacement(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondAnimation) => route,
        transitionsBuilder: (context, animation, secondAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  /// Replaces the current screen with a named route.
  /// Optionally, pass [arguments] to the route.
  void navigateToReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  /// Navigates to a named route and removes all previous routes from the stack.
  void navigateAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (route) => false, // Remove all previous routes
      arguments: arguments,
    );
  }

  /// Pops the current screen from the navigation stack.
  void pop() {
    Navigator.pop(this);
  }

  /// Pops the navigation stack until a route with the specified [routeName] is found.
  void popUntil(String routeName) {
    Navigator.popUntil(
      this,
      ModalRoute.withName(routeName),
    );
  }
}
