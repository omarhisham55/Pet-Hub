import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class Breed extends StatelessWidget {
  const Breed({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SearchBar(
              backgroundColor: MaterialStatePropertyAll(SharedModeColors.white),
              elevation: const MaterialStatePropertyAll(0),
              hintText: 'Search by breed',
              hintStyle: MaterialStatePropertyAll(
                Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: SharedModeColors.grey500),
              ),
              leading: Icon(
                Icons.search,
                color: SharedModeColors.grey500,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: SharedModeColors.grey500),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: PetsImages
                  .pets[ProfileSetupCubit.get(context).category]!.entries
                  .map((pet) => _gridViewItem(context, pet))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridViewItem(BuildContext context, MapEntry<String, String> pet) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
        builder: (context, state) {
      return ModedContainer(
        padding: const EdgeInsets.only(bottom: 0, top: 20),
        onTap: () =>
            ProfileSetupCubit.get(context).changeDetailedCategory(pet.key),
        selectedContainer:
            ProfileSetupCubit.get(context).detailedCategory == pet.key
                ? SharedModeColors.grey600
                : null,
        child: Column(
          children: [
            Text(
              pet.key,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(child: Image.asset(pet.value)),
          ],
        ),
      );
    });
  }
}
