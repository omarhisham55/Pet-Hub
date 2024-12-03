import 'package:pet_app/config/services/preferences/shared_preferences.dart';

const baseLightImgPath = 'assets/images/lightImages';
const baseDarkImgPath = 'assets/images/darkImages';
const baseSharedImgPath = 'assets/images/sharedImages';
const baseLottiesPath = 'assets/images/lottie';

String themeImage(String folderPath) {
  return LocalSharedPreferences.isDarkTheme()
      ? '$baseDarkImgPath/$folderPath'
      : '$baseLightImgPath/$folderPath';
}

final String splashPath = themeImage('splash_screen');
const String noImage = '$baseSharedImgPath/noImage.png';
const String settingsPath = '$baseSharedImgPath/settings';
const String birdsPath = '$baseSharedImgPath/pets/birds';
const String catsPath = '$baseSharedImgPath/pets/cats';
const String dogsPath = '$baseSharedImgPath/pets/dogs';
const String hamstersPath = '$baseSharedImgPath/pets/hamsters';
const String turtlesPath = '$baseSharedImgPath/pets/turtles';
final String profileSetupPath = themeImage('profile');
final String profilehealthPath = themeImage('profile/health');
final String profileNutritionPath = themeImage('profile/nutrition');
final String profileActivitiesPath = themeImage('profile/activities');

class SplashImages {
  static final String logo = '$splashPath/logo.png';
  static final String background = '$splashPath/bg.png';
}

class LoadingLotties {
  static final String error = '$baseLottiesPath/error.json';
  static final String paws = '$baseLottiesPath/paws.json';
  static final String walkingDog = '$baseLottiesPath/walking_dog.json';
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
  static const String timeZone = '$settingsPath/timeZone.png';
  static const String language = '$settingsPath/language.png';
  static const String darkMode = '$settingsPath/darkMode.png';
  static const String locationAccess = '$settingsPath/locationAccess.png';
  static const String photoAccess = '$settingsPath/photoAccess.png';
  static const String appNotifications = '$settingsPath/appNotifications.png';
  static const String emailNotifications =
      '$settingsPath/emailNotifications.png';
}
