import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/set_view_profile_content.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';

class ViewPetProfile extends StatelessWidget {
  const ViewPetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoTitleAppbar(
        context: context,
        title: 'Pet Profile',
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              color: SharedModeColors.grey150,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: SharedModeColors.grey200,
                ),
              ),
              elevation: 0,
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Maxi'),
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
          text: 'Edit',
          onPressed: () =>
              ProfileSetupCubit.get(context).addNewPetProfile(context),
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
    return GestureDetector(
      onTap: () => manager.changePetProfileView(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SharedModeColors.grey200),
          color: manager.currentProfileSection == index
              ? SharedModeColors.yellow500
              : SharedModeColors.grey150,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: manager.currentProfileSection == index
                    ? SharedModeColors.white
                    : null,
              ),
        ),
      ),
    );
  }
}
