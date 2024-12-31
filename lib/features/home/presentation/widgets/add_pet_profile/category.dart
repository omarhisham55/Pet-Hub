import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/domain/entities/pet_category.dart';
import 'package:pet_app/features/home/presentation/cubit/add_pet_cubit/add_pet_to_user_bloc.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  void _refresh(BuildContext context) {
    context.read<AddPetBloc>().add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddPetBloc, AddPetState, ResponseStatus>(
      selector: (state) => state.responseStatus ?? ResponseStatus.success,
      builder: (context, state) {
        final cubit = context.read<AddPetBloc>();
        Future.microtask(() => cubit.add(GetCategoriesEvent()));
        if (state == ResponseStatus.error) {
          return ErrorWidgetAndRetry(
            errorMessage: (state as AddPetState).messageError ?? '',
            retryFunction: () => _refresh(context),
          );
        } else if (cubit.petsCategories.isNotEmpty) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SearchBar(
                    backgroundColor:
                        WidgetStatePropertyAll(SharedModeColors.white),
                    elevation: const WidgetStatePropertyAll(0),
                    hintText: MainStrings.addPetCategoryHint,
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
                  cubit.petsCategories.isEmpty
                      ? ErrorWidgetAndRetry(
                          errorMessage: ErrorStrings.emptyList,
                          retryFunction: () => _refresh(context),
                        )
                      : GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          children: cubit.petsCategories
                              .map((pet) => _gridViewItem(context, pet))
                              .toList(),
                        ),
                ],
              ),
            ),
          );
        } else {
          return Lottie.asset(LoadingLotties.paws);
        }
      },
    );
  }

  Widget _gridViewItem(
    BuildContext context,
    PetCategory pet,
  ) {
    return BlocSelector<AddPetBloc, AddPetState, String>(
      selector: (state) => state.category,
      builder: (context, selectedCategory) {
        final AddPetBloc cubit = context.read<AddPetBloc>();
        final bool isSelected = selectedCategory == pet.category;
        return ModedContainer(
          onTap: () => cubit.add(ChangeItemEvent(item: pet.category)),
          selectedContainer: isSelected ? SharedModeColors.grey600 : null,
          child: Column(
            children: [
              Text(
                pet.category,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(child: ImageHandler(imageBytes: pet.imgUrl)),
            ],
          ),
        );
      },
    );
  }
}
