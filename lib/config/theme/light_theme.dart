import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_app/core/utils/colors.dart';

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: SharedModeColors.grey150,
  iconTheme: IconThemeData(
    color: SharedModeColors.blue500,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
        // statusBarBrightness: Brightness.light,
        // statusBarIconBrightness: Brightness.dark,
        ),
    backgroundColor: SharedModeColors.grey100,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: SharedModeColors.grey800,
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
