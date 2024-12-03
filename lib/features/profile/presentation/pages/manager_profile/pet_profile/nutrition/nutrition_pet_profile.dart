import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class NutritionPetProfile extends StatelessWidget {
  const NutritionPetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _categories(context),
            const SizedBox(height: 10),
            _schedualedMeals(context),
          ],
        ),
      ),
    );
  }

  Widget _categories(BuildContext context) {
    Widget categoryItem(
      BuildContext context,
      String title,
      String img,
      Function() onTap, {
      IconData? icon,
    }) {
      return ModedContainer(
        onTap: onTap,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: Image.asset(
              img,
              fit: BoxFit.cover,
            )),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            if (icon != null) Icon(icon),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: categoryItem(
                context,
                'Kibble / Dry',
                NutritionImages.kibbleDry,
                () {},
              ),
            ),
            Expanded(
              child: categoryItem(
                context,
                'Home cooked',
                NutritionImages.homeCooked,
                () {},
              ),
            ),
          ],
        ),
        categoryItem(
          context,
          'Recipes',
          NutritionImages.recipes,
          () => Constants.navigateTo(
            context,
            Routes.recipes,
            arguments: 'recipes',
          ),
          icon: Icons.add,
        ),
        categoryItem(
          context,
          'Food Journal',
          NutritionImages.dogFood,
          () {},
          icon: Icons.add,
        ),
      ],
    );
  }

  Widget _schedualedMeals(BuildContext context) {
    Widget schedualedMealItem(BuildContext context, int index) {
      return ModedContainer(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Breakfast',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: SharedModeColors.grey500,
                      ),
                      Text(
                        ' everyday | ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(
                        Icons.access_time_sharp,
                        color: SharedModeColors.grey500,
                      ),
                      Text(
                        '10:00',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
              builder: (context, state) {
                return settingSwitch(
                  value: ProfileSetupCubit.get(context).isSwitchedOn[index],
                  onChanged: (value) =>
                      ProfileSetupCubit.get(context).toggleSwitch(index),
                );
              },
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schedualed Meals',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => schedualedMealItem(context, index),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: 5,
        ),
      ],
    );
  }
}
