import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/domain/entities/pet.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/set_view_profile_content.dart';

class ViewPetProfile extends StatelessWidget {
  final Pet pet;
  const ViewPetProfile({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwoTitleAppbar(
        title: MainStrings.addProfile,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              color: ThemeManager.currentTheme == ThemeState.lightTheme
                  ? SharedModeColors.grey150
                  : SharedModeColors.grey800,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(pet.name),
                  ),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
          ),
        ],
      ),
      body: _profile(context),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: GlobalButton(
          text: MainStrings.edit,
          onPressed: () {
            // return ProfileSetupCubit.get(context).addNewPetProfile(context);
          },
        ),
      ),
    );
  }

  Widget _profile(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        ProfileSetupCubit manager = ProfileSetupCubit.get(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          manager.infoListController.jumpTo(manager.currentProfileSection * 50);
        });
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 70),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    shrinkWrap: true,
                    controller: manager.infoListController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => __infoListItem(
                      context,
                      viewProfileBody(context).keys.toList()[index],
                      index,
                      manager,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: viewProfileBody(context).length,
                  ),
                ),
                profileBody(
                  context,
                  viewProfileBody(context)
                      .keys
                      .toList()[manager.currentProfileSection],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget __infoListItem(
    BuildContext context,
    String title,
    int index,
    ProfileSetupCubit manager,
  ) {
    return ModedContainer(
      onTap: () => manager.changePetProfileView(index),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      margin: EdgeInsets.zero,
      borderRadius: 8,
      selectedContainer: manager.currentProfileSection == index
          ? SharedModeColors.yellow500
          : null,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: manager.currentProfileSection == index
                  ? SharedModeColors.white
                  : null,
            ),
      ),
    );
  }
}
