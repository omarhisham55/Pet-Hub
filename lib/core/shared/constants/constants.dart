import 'package:flutter/material.dart';

class Constants {
  static final String dogBG = 'dogBG';

  static const String localIsOnBoardingComplete = 'isOnBoardingComplete';
  static const String localIsCreateAccountComplete = 'isCreateAccountComplete';
  static const String localUserId = 'currentUserId';
  static const String localNumberOfPets = 'numberOfPets';
  static const String localIsDarkTheme = 'darkTheme';

  static const String firestoreUserCollection = 'users';
  static const String firestoreCategoriesCollection = 'categories';
  static const String firestorePetsCollection = 'pets';
  static const String firestorePetsBreedsCollection = 'breeds';

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
