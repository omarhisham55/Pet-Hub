import 'package:flutter/material.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/activities/activity_items/profile_activity_manager.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/activities/activity_items/tricks.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/activities/activity_items/walk.dart';

class ActivitiesPetProfile extends StatelessWidget {
  const ActivitiesPetProfile({super.key});

  static Map<String, dynamic> activities = {
    'Walks': const WalkActivity(),
    'Tricks': const TricksActivity(),
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: activities.length,
      itemBuilder: (context, index) => _activityItem(
        context,
        activities.entries.toList()[index],
      ),
    );
  }

  Widget _activityItem(
    BuildContext context,
    MapEntry<String, dynamic> activity,
  ) {
    return GestureDetector(
      onTap: () => Constants.navigateTo(
        context,
        Routes.intoActivities,
        arguments: ProfileActivityArguments(
          subTitle: activity.key,
          body: activity.value,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: SharedModeColors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              blurRadius: .2,
              color: SharedModeColors.grey500,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(ProfileImages.healthCard),
            Text(
              activity.key,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
