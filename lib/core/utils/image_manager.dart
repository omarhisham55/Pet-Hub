import 'package:pet_app/config/preferences/shared_preferences.dart';

const baseLightImgPath = 'assets/images/lightImages';
const baseDarkImgPath = 'assets/images/darkImages';

String themeImage(String folderPath) {
  return LocalSharedPreferences.darkTheme()
      ? '$baseDarkImgPath/$folderPath'
      : '$baseLightImgPath/$folderPath';
}

final String splashPath = themeImage('splash_screen');
final String settingsPath = themeImage('settings');
final String profileSetupPath = themeImage('profile');
final String profilehealthPath = themeImage('profile/health');
final String profileNutritionPath = themeImage('profile/nutrition');
final String profileActivitiesPath = themeImage('profile/activities');

class SplashImages {
  static final String logo = '$splashPath/logo.png';
  static final String background = '$splashPath/bg.png';
}

class ProfileImages {
  static final String noProfileSetup = '$profileSetupPath/no_profile_setup.png';
  static final String healthCard = '$profileSetupPath/health_card.png';
  static final String nutrition = '$profileSetupPath/nutrition.png';
  static final String activities = '$profileSetupPath/activities.png';
  static final String emptyInsurance = '$profileSetupPath/empty_insurance.png';
  static final String contactBg = '$profileSetupPath/contactBg.png';
  static final String haircutSalon = '$profileSetupPath/haircutSalon.png';
}

class HealthImages {
  static final String insurance = '$profilehealthPath/insurance.png';
  static final String vaccines = '$profilehealthPath/vaccines.png';
  static final String antiParasiticalTreatment =
      '$profilehealthPath/anti-parasitical_treatment.png';
  static final String medicalIntervention =
      '$profilehealthPath/medical_intervention.png';
  static final String otherTreatment = '$profilehealthPath/other_treatment.png';
}

class NutritionImages {
  static final List<String> recipe = [
    '$profileNutritionPath/recipe1.png',
    '$profileNutritionPath/recipe2.png',
    '$profileNutritionPath/recipe3.png'
  ];
  static final String recipes = '$profileNutritionPath/recipes.png';
  static final String dogFood = '$profileNutritionPath/dog_food.png';
  static final String homeCooked = '$profileNutritionPath/home_cooked.png';
  static final String kibbleDry = '$profileNutritionPath/kibble_dry.png';
}

class ActivitiesImages {
  static final String handshake = '$profileActivitiesPath/handshake.png';
  static final String sit = '$profileActivitiesPath/sit.png';
}

class SettingsImages {
  static final String timeZone = '$settingsPath/timeZone.png';
  static final String language = '$settingsPath/language.png';
  static final String darkMode = '$settingsPath/darkMode.png';
  static final String locationAccess = '$settingsPath/locationAccess.png';
  static final String photoAccess = '$settingsPath/photoAccess.png';
  static final String appNotifications = '$settingsPath/appNotifications.png';
  static final String emailNotifications =
      '$settingsPath/emailNotifications.png';
}
