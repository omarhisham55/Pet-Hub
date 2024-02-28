import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';

class Recipes extends StatelessWidget {
  const Recipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoTitleAppbar(
        context: context,
        title: 'Pet Profile',
        subTitle: 'Recipes',
        titleAlignment: CrossAxisAlignment.start,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: _recipeGridView(context)),
            OutlinedGlobalButton(
              text: '+  Add recipe',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _recipeGridView(BuildContext context) {
    Widget recipeGridViewItem(BuildContext context, int index) {
      return Container(
        padding: const EdgeInsets.only(bottom: 10, left: 15),
        decoration: BoxDecoration(
          color: SharedModeColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(blurRadius: .2, color: SharedModeColors.grey500)
          ],
        ),
        child: Column(
          children: [
            Expanded(child: Image.asset(NutritionImages.recipe[index])),
            Text(
              'Doggy Meatload with vegetables',
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(
        3,
        (index) => recipeGridViewItem(context, index),
      ),
    );
  }
}
