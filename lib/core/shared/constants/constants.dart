import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  static const String firestoreProductsCollection = 'products';
  static const String firestoreProductsCommentsAndReviewsCollection =
      'comments&reviews';

  static void navigateTo(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) =>
      GoRouter.of(context).push(route, extra: arguments);

  static void replaceWith(BuildContext context, String route) =>
      GoRouter.of(context).pushReplacement(route);

  static void replaceWithAndRemoveUntil(BuildContext context, String route) =>
      GoRouter.of(context).replace(route);

  static void pop(BuildContext context) => GoRouter.of(context).pop();
}
