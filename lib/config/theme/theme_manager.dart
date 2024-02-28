import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/preferences/shared_preferences.dart';
import 'package:pet_app/config/theme/dark_theme.dart';
import 'package:pet_app/config/theme/light_theme.dart';
import 'package:pet_app/core/utils/strings.dart';

enum ThemeEvent { lightTheme, darkTheme }

class ThemeState extends Equatable {
  final ThemeData themeData;

  const ThemeState({required this.themeData});

  static ThemeState get darkTheme => ThemeState(themeData: darkThemeData);

  static ThemeState get lightTheme => ThemeState(themeData: lightThemeData);

  @override
  List<Object?> get props => [themeData];
}

class ThemeManager extends Cubit<ThemeState> {
  ThemeManager()
      : super(
          LocalSharedPreferences.darkTheme()
              ? ThemeState.darkTheme
              : ThemeState.lightTheme,
        );

  static ThemeManager get(context) => BlocProvider.of<ThemeManager>(context);

  static late ThemeState currentTheme;

  void toggleTheme(ThemeEvent event) {
    switch (event) {
      case ThemeEvent.lightTheme:
        LocalSharedPreferences.saveLocalPreferences(
            SharedPreferencesKeys.darkTheme, false);
        emit(ThemeState.lightTheme);
        break;
      case ThemeEvent.darkTheme:
        LocalSharedPreferences.saveLocalPreferences(
            SharedPreferencesKeys.darkTheme, true);
        emit(ThemeState.darkTheme);
        break;
    }
  }
}
