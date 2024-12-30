import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';

List insuranceBottomSheets(int index) {
  return switch (index) {
    0 => ['Packages', const InsurancePackages()],
    1 => ['Packages Details', const InsurancePackageDetails()],
    2 => ['How it works', const InsuranceAddPackage()],
    int() => [],
  };
}

class InsurancePackages extends StatelessWidget {
  const InsurancePackages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        packageItem(context, 0),
        packageItem(context, 1),
        packageItem(context, 2),
      ],
    );
  }

  Widget packageItem(BuildContext context, int index) {
    return BlocBuilder<PetProfileCubit, PetProfileState>(
      builder: (context, state) {
        PetProfileCubit manager = PetProfileCubit.get(context);
        return ModedContainer(
          onTap: () => manager.changeInsurancePackage(index),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          margin: const EdgeInsets.symmetric(vertical: 15),
          borderRadius: 20,
          border: manager.insurancePackage == index
              ? Border.all(color: SharedModeColors.blue500, width: 2)
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.umbrella_outlined),
              Text(
                'Basic Pack',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Text('\$ 20 /month'),
            ],
          ),
        );
      },
    );
  }
}

class InsurancePackageDetails extends StatelessWidget {
  const InsurancePackageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Comfy Pack',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _packageItem(context),
            separatorBuilder: (context, index) => const Divider(height: 30),
            itemCount: 5,
          ),
        ],
      ),
    );
  }

  Widget _packageItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Accidents and Injuries',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '\$ 20.00',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class InsuranceAddPackage extends StatelessWidget {
  const InsuranceAddPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          _steps(context, 0),
          _steps(context, 1),
          _steps(context, 2),
        ],
      ),
    );
  }

  Widget _steps(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            color: SharedModeColors.green500,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Take your pet to the vet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Visit any licenced vet, emergency client or specialist in the U.S. There\'s no network of providers to worry about.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
