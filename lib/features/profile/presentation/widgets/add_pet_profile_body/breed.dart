import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/domain/entities/pet_category.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class Breed extends StatelessWidget {
  const Breed({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileSetupCubit>();
    List<PetBreedCategory> breed = cubit.petsCategories
        .where((element) => element.category == cubit.category)
        .first
        .breeds;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SearchBar(
              backgroundColor: WidgetStatePropertyAll(SharedModeColors.white),
              elevation: const WidgetStatePropertyAll(0),
              hintText: 'Search by breed',
              hintStyle: WidgetStatePropertyAll(
                Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: SharedModeColors.grey500),
              ),
              leading: Icon(
                Icons.search,
                color: SharedModeColors.grey500,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: SharedModeColors.grey500),
                ),
              ),
            ),
            const SizedBox(height: 20),
            breed.isEmpty
                ? ErrorWidgetAndRetry(
                    errorMessage: ErrorStrings.emptyList,
                    retryFunction: () {},
                  )
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: breed
                        .map((pet) => _gridViewItem(context, pet))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _gridViewItem(BuildContext context, PetBreedCategory pet) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
        builder: (context, state) {
      final cubit = context.read<ProfileSetupCubit>();
      return ModedContainer(
        padding: const EdgeInsets.only(bottom: 0, top: 20),
        onTap: () => cubit.changeBreed(pet.breed),
        selectedContainer:
            cubit.breed == pet.breed ? SharedModeColors.grey600 : null,
        child: Column(
          children: [
            Text(
              pet.breed,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(child: ImageHandler(image: pet.imgUrl)),
          ],
        ),
      );
    });
  }
}
