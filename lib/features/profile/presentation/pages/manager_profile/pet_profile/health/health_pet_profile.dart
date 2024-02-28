import 'package:flutter/material.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';

class HealthPetProfile extends StatelessWidget {
  const HealthPetProfile({super.key});

  static Map<int, List<dynamic>> items = {
    0: [HealthImages.insurance, 'Insurance'],
    1: [HealthImages.vaccines, 'Vaccines'],
    2: [HealthImages.antiParasiticalTreatment, 'Anti-parasitical treatments'],
    3: [HealthImages.medicalIntervention, 'Medical interventions'],
    4: [HealthImages.otherTreatment, 'other treatments'],
  };
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      itemBuilder: (context, index) => _healthItem(context, index),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: 5,
    );
  }

  Widget _healthItem(BuildContext context, int index) => GestureDetector(
        onTap: () => Constants.navigateTo(
          context,
          Routes.petProfileHealthDetails,
          arguments: items.values.toList()[index][1],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            color: SharedModeColors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: SharedModeColors.grey200, blurRadius: 5),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Image.asset(
                  items.values.toList()[index][0],
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Text(
                  items.values.toList()[index][1],
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                ),
              ),
              const Icon(Icons.add),
            ],
          ),
        ),
      );
}
