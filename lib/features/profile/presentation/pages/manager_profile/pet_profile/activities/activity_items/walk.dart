import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/activities/activity_items/open_maps.dart';

class WalkActivity extends StatelessWidget {
  const WalkActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const MapSmallView(),
              Container(
                margin: const EdgeInsets.all(30),
                child: const EventItem(),
              )
            ],
          ),
          _walkTimings(context),
        ],
      ),
    );
  }

  Widget _walkTimings(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => const EventItem(),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}
