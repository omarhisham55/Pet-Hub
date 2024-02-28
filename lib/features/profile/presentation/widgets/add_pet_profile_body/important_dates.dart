import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/body_manager.dart';

class ImportantDates extends StatelessWidget {
  const ImportantDates({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
        builder: (context, state) {
      ProfileSetupCubit manager = ProfileSetupCubit.get(context);
      return SetProfileBodyMainContent(
        title: 'Time to celebrate',
        manager: manager,
        child: Column(
          children: [
            importantDatesRowItem(
              context: context,
              icon: Icons.cake_outlined,
              title: 'Birthday',
              date: manager.birthDate,
              suffix: manager.petAge,
              onTap: () {
                debugPrint('openCalendar: {openCalendar}');
                return manager.openBirthCalendar(context);
              },
            ),
            importantDatesRowItem(
              context: context,
              icon: Icons.house_outlined,
              title: 'Adoption day',
              date: manager.adoptionDate,
              suffix: manager.petAdoptionAge,
              onTap: () => manager.openAdoptionCalendar(context),
            ),
          ],
        ),
      );
    });
  }
}
