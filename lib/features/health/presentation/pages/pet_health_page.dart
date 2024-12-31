import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';

part 'package:pet_app/features/health/presentation/widgets/upcomming_vet_visits_section.dart';
part 'package:pet_app/features/health/presentation/widgets/upcomming_vet_visits_item.dart';
part 'package:pet_app/features/health/presentation/widgets/medication_schedule_section.dart';
part 'package:pet_app/features/health/presentation/widgets/find_a_vet_section.dart';

class PetHealthPage extends StatelessWidget {
  const PetHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      children: const [
        UpcommingVetVisitsSection(),
        MedicationScheduleSection(),
        FindAVetSection(),
      ],
    );
  }
}
