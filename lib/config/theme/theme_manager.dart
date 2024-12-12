import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/config/theme/themes.dart';
import 'package:pet_app/core/shared/constants/constants.dart';

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
          LocalSharedPreferences.isDarkTheme()
              ? ThemeState.darkTheme
              : ThemeState.lightTheme,
        );

  static ThemeManager get(context) => BlocProvider.of<ThemeManager>(context);

  static late ThemeState currentTheme;

  void toggleTheme(ThemeEvent event) {
    switch (event) {
      case ThemeEvent.lightTheme:
        LocalSharedPreferences.write(Constants.localIsDarkTheme, false);
        emit(ThemeState.lightTheme);
        break;
      case ThemeEvent.darkTheme:
        LocalSharedPreferences.write(Constants.localIsDarkTheme, true);
        emit(ThemeState.darkTheme);
        break;
    }
  }
}
