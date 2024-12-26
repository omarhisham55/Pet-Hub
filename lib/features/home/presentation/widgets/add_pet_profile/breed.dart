import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/domain/entities/pet_category.dart';
import 'package:pet_app/features/home/presentation/cubit/add_pet_to_user_bloc.dart';

class Breed extends StatelessWidget {
  const Breed({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPetBloc>();
    List<PetBreedCategory> breed = cubit.petsCategories
        .where((element) => element.category == cubit.state.category)
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
              hintText: MainStrings.addPetBreedHint,
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
    return BlocSelector<AddPetBloc, AddPetState, String>(
        selector: (state) => state.breed,
        builder: (context, selectedBreed) {
          final cubit = context.read<AddPetBloc>();
          final bool isSelected = selectedBreed == pet.breed;
          return ModedContainer(
            padding: const EdgeInsets.only(bottom: 0, top: 20),
            onTap: () => cubit.add(ChangeItemEvent(item: pet.breed)),
            selectedContainer: isSelected ? SharedModeColors.grey600 : null,
            child: Column(
              children: [
                Text(
                  pet.breed,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(child: ImageHandler(imageBytes: pet.imgUrl)),
              ],
            ),
          );
        });
  }
}
