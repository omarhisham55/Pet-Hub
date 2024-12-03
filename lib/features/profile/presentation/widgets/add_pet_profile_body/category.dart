import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/domain/entities/pet_category.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        final cubit = context.read<ProfileSetupCubit>();
        if (state is LoadingPetsCategories) {
          return Lottie.asset(LoadingLotties.paws);
        } else if (state is ErrorPetsCategories) {
          return ErrorWidgetAndRetry(
            errorMessage: state.error,
            retryFunction: context.read<ProfileSetupCubit>().getPetsCategories,
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SearchBar(
                    backgroundColor:
                        WidgetStatePropertyAll(SharedModeColors.white),
                    elevation: const WidgetStatePropertyAll(0),
                    hintText: 'Search by pet type',
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
                          retryFunction: () {},
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
        }
      },
    );
  }

  Widget _gridViewItem(
    BuildContext context,
    PetCategory category,
  ) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        final cubit = context.read<ProfileSetupCubit>();
        return ModedContainer(
          onTap: () => cubit.changeCategory(category.category),
          selectedContainer: cubit.category == category.category
              ? SharedModeColors.grey600
              : null,
          child: Column(
            children: [
              Text(
                category.category,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(child: ImageHandler(image: category.imgUrl)),
            ],
          ),
        );
      },
    );
  }
}
