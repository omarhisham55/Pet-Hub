import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_app/core/utils/colors.dart';

ThemeData darkThemeData = ThemeData(
  scaffoldBackgroundColor: SharedModeColors.grey1000,
  iconTheme: IconThemeData(
    color: SharedModeColors.blue500,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: SharedModeColors.darkBackground,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: SharedModeColors.grey1000,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: SharedModeColors.darkBackground,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: SharedModeColors.white,
    unselectedItemColor: SharedModeColors.grey500,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  brightness: Brightness.dark,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: SharedModeColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Catamaran',
    ),
    titleMedium: TextStyle(
      color: SharedModeColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Catamaran',
    ),
    titleSmall: TextStyle(
      color: SharedModeColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Catamaran',
    ),
    bodyLarge: TextStyle(
      color: SharedModeColors.white,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      color: SharedModeColors.grey200,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(color: SharedModeColors.darkBackground),
  ),
  fontFamily: 'Noto Sans',
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: SharedModeColors.darkBackground,
  ),
);

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: SharedModeColors.grey150,
  iconTheme: IconThemeData(
    color: SharedModeColors.blue500,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: SharedModeColors.grey100,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: SharedModeColors.grey800,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: SharedModeColors.lightBackground,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: SharedModeColors.black,
    unselectedItemColor: SharedModeColors.grey500,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  brightness: Brightness.light,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: SharedModeColors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Catamaran',
    ),
    titleMedium: TextStyle(
      color: SharedModeColors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Catamaran',
    ),
    titleSmall: TextStyle(
      color: SharedModeColors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Catamaran',
    ),
    bodyLarge: TextStyle(
      color: SharedModeColors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      color: SharedModeColors.grey500,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(color: SharedModeColors.white),
  ),
  fontFamily: 'Noto Sans',
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: SharedModeColors.grey100,
  ),
);
