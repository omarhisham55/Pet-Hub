import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class VaccineBottomSheetDetails extends StatelessWidget {
  const VaccineBottomSheetDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'vaccine name',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            _vaccineDetails(context),
            const SizedBox(height: 20),
            _vaccineDate(context),
            const SizedBox(height: 20),
            _vetSpecialist(context, 'Martha Roth'),
            const SizedBox(height: 20),
            _notes(context),
            const SizedBox(height: 20),
            GlobalButton(
              text: 'Done',
              onPressed: () =>
                  ProfileSetupCubit.get(context).panelVaccineController.close(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vaccineDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _titleDetail(context, 'Lot', 'A583D01'),
            _titleDetail(context, 'Expiry Date', '07-2023'),
          ],
        ),
      ],
    );
  }

  Widget _vaccineDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _titleDetail(context, 'Vaccination date', '18.05.2023'),
            _titleDetail(context, 'Valid until', '18.09.2025'),
          ],
        ),
      ],
    );
  }

  Widget _titleDetail(BuildContext context, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: SharedModeColors.black),
          ),
          Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: SharedModeColors.black),
          ),
        ],
      ),
    );
  }

  Widget _vetSpecialist(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Veterinarian',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SharedModeColors.grey200),
          ),
          child: Row(
            children: [
              const CircleAvatar(),
              _titleDetail(context, name, 'Vererinary Specialist'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _notes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '   No bod reactions',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
