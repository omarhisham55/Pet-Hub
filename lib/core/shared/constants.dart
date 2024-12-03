import 'package:flutter/material.dart';

class Constants {
  static void navigateTo(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) =>
      Navigator.pushNamed(
        context,
        route,
        arguments: arguments,
      );
  static void replaceWith(BuildContext context, String route) =>
      Navigator.pushReplacementNamed(context, route);
  static void replaceWithAndRemoveUntil(BuildContext context, String route) =>
      Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        (route) => false,
      );
  static void pop(BuildContext context) => Navigator.pop(context);
}
