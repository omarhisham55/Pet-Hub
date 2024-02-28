const baseImgPath = 'assets/images';
const splashPath = '$baseImgPath/splash_screen';
const settingsPath = '$baseImgPath/settings';
const profileSetupPath = '$baseImgPath/profile';
const profilehealthPath = '$baseImgPath/profile/health';
const profileNutritionPath = '$baseImgPath/profile/nutrition';
const profileActivitiesPath = '$baseImgPath/profile/activities';

class SplashImages {
  static const String logo = '$splashPath/logo.png';
  static const String background = '$splashPath/bg.png';
}

class ProfileImages {
  static const String noProfileSetup = '$profileSetupPath/no_profile_setup.png';
  static const String healthCard = '$profileSetupPath/health_card.png';
  static const String nutrition = '$profileSetupPath/nutrition.png';
  static const String activities = '$profileSetupPath/activities.png';
  static const String emptyInsurance = '$profileSetupPath/empty_insurance.png';
  static const String contactBg = '$profileSetupPath/contactBg.png';
  static const String haircutSalon = '$profileSetupPath/haircutSalon.png';
}

class HealthImages {
  static const String insurance = '$profilehealthPath/insurance.png';
  static const String vaccines = '$profilehealthPath/vaccines.png';
  static const String antiParasiticalTreatment =
      '$profilehealthPath/anti-parasitical_treatment.png';
  static const String medicalIntervention =
      '$profilehealthPath/medical_intervention.png';
  static const String otherTreatment = '$profilehealthPath/other_treatment.png';
}

class NutritionImages {
  static const List<String> recipe = [
    '$profileNutritionPath/recipe1.png',
    '$profileNutritionPath/recipe2.png',
    '$profileNutritionPath/recipe3.png'
  ];
  static const String recipes = '$profileNutritionPath/recipes.png';
  static const String dogFood = '$profileNutritionPath/dog_food.png';
  static const String homeCooked = '$profileNutritionPath/home_cooked.png';
  static const String kibbleDry = '$profileNutritionPath/kibble_dry.png';
}

class ActivitiesImages {
  static const String handshake = '$profileActivitiesPath/handshake.png';
  static const String sit = '$profileActivitiesPath/sit.png';
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
