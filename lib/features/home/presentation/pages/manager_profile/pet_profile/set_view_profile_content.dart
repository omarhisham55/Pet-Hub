import 'package:flutter/material.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/activities/activities_pet_profile.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/add_profile.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/health/health_pet_profile.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/nutrition/nutrition_pet_profile.dart';

Map<String, Widget> viewProfileBody(BuildContext context) => {
      'About': const AddNewPetProfile().profile(context, canEdit: true),
      'Health': const HealthPetProfile(),
      'Nutrition': const NutritionPetProfile(),
      'Activities': const ActivitiesPetProfile(),
    };
Widget profileBody(BuildContext context, String title) {
  return viewProfileBody(context)[title] ?? Container();
}
