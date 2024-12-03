import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/core/shared/constants/constants.dart';

class AuthGateChecks {
  static bool isAuthenticatedCheck() =>
      LocalSharedPreferences.read(Constants.localIsCreateAccountComplete);

  static bool isOnBoardingCompleteCheck() =>
      LocalSharedPreferences.read(Constants.localIsOnBoardingComplete);
}
