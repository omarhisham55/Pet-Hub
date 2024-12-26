import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/health/health_items/insurance.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/health/health_items/vaccines.dart';

class PetProfileHealthDetails extends StatelessWidget {
  final String subTitle;
  const PetProfileHealthDetails({super.key, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwoTitleAppbar(
        title: 'Pet Profile',
        subTitle: subTitle,
        titleAlignment: CrossAxisAlignment.start,
        boldTitle: false,
        boldSubTitle: true,
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
