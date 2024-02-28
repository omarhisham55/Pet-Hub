import 'package:pet_app/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreferences {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveLocalPreferences(String key, dynamic value) async {
    return switch (value.runtimeType) {
      const (String) => await sharedPreferences.setString(key, value),
      const (int) => await sharedPreferences.setInt(key, value),
      const (double) => await sharedPreferences.setDouble(key, value),
      const (bool) => await sharedPreferences.setBool(key, value),
      _ => false,
    };
  }

  static dynamic getLocalPreferences(String key) {
    return sharedPreferences.containsKey(key)
        ? sharedPreferences.get(key)
        : false;
  }

  static bool darkTheme() {
    return getLocalPreferences(SharedPreferencesKeys.darkTheme);
  }
}
