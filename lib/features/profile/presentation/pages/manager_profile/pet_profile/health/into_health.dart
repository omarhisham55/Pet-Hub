import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/health/health_items/insurance.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/health/health_items/vaccines.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';

class PetProfileHealthDetails extends StatelessWidget {
  final String subTitle;
  const PetProfileHealthDetails({super.key, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoTitleAppbar(
        context: context,
        title: 'Pet Profile',
        subTitle: subTitle,
        titleAlignment: CrossAxisAlignment.start,
        titleStyle: Theme.of(context).textTheme.bodyMedium,
        subTitleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: SharedModeColors.black,
            ),
      ),
      body: _selectedHealthItem(),
    );
  }

  Widget _selectedHealthItem() {
    return switch (subTitle.toLowerCase()) {
      'insurance' => const Insurance(),
      'vaccines' => const Vaccines(),
      String() => Container(),
    };
  }
}
