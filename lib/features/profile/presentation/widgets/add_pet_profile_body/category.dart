import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class Category extends StatelessWidget {
  const Category({super.key});

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
              hintText: 'Search by vaccine type',
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
              children: PetsImages.pets.entries
                  .map((pet) => _gridViewItem(context, pet))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridViewItem(
    BuildContext context,
    MapEntry<String, Map<String, String>> category,
  ) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        return ModedContainer(
          onTap: () =>
              ProfileSetupCubit.get(context).changeCategory(category.key),
          selectedContainer:
              ProfileSetupCubit.get(context).category == category.key
                  ? SharedModeColors.grey600
                  : null,
          child: Column(
            children: [
              Text(
                category.key,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(child: Image.asset(category.value.values.first)),
            ],
          ),
        );
      },
    );
  }
}
