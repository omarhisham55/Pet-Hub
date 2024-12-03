import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> write(String key, dynamic value) async {
    return switch (value.runtimeType) {
      const (String) => await _sharedPreferences.setString(key, value),
      const (int) => await _sharedPreferences.setInt(key, value),
      const (double) => await _sharedPreferences.setDouble(key, value),
      const (bool) => await _sharedPreferences.setBool(key, value),
      _ => false,
    };
  }

  static dynamic read(String key, {dynamic fallBack = false}) {
    return _sharedPreferences.containsKey(key)
        ? _sharedPreferences.get(key)
        : fallBack;
  }

  static Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  static bool isDarkTheme() {
    return read(Constants.localIsDarkTheme, fallBack: true);
  }

  static int numberOfPets() {
    return read(Constants.localNumberOfPets, fallBack: 0);
  }
}
