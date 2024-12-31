import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/core/shared/components/buttons/dropdown_button.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/shared/components/dialogs/exit_dialog.dart';
import 'package:pet_app/core/shared/components/toast.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/domain/entities/pet.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/activities/activities_pet_profile.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/add_profile.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/health/health_pet_profile.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/nutrition/nutrition_pet_profile.dart';

class ViewPetProfile extends StatelessWidget {
  final Pet pet;
  const ViewPetProfile({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PetProfileCubit>();
    final List<String> dropDownItems = const [
      MainStrings.edit,
      MainStrings.share,
      MainStrings.delete,
    ];
    return BlocListener<PetProfileCubit, PetProfileState>(
      listener: (context, state) {
        if (state is DeletePetErrorState) {
          showToast(text: state.message, state: ToastStates.error);
        }
        if (state is DeletePetSuccessState) {
          Constants.pop(context);
          showToast(text: MainStrings.petDeleted, state: ToastStates.success);
        }
      },
      child: Scaffold(
        appBar: TwoTitleAppbar(
          title: MainStrings.addProfile,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ManagePetDropDownButton<String>(
                dropdownItems: dropDownItems,
                specifiedColors: {
                  dropDownItems[1]: SharedModeColors.blue500,
                  dropDownItems[2]: SharedModeColors.red500,
                },
                onItemClick: (value) {
                  if (value == dropDownItems[0]) {
                    showToast(text: 'Product edit', state: ToastStates.warning);
                  } else if (value == dropDownItems[1]) {
                    showToast(
                        text: 'Product share', state: ToastStates.warning);
                  } else if (value == dropDownItems[2]) {
                    showExitDialog(
                      context: context,
                      title: MainStrings.deletePetExitDialogTitle,
                      titleAlign: TextAlign.center,
                      onAgreeClick: () {
                        Constants.pop(context);
                        cubit.deletePetFromUser(pet.id);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        body: _profile(context),
      ),
    );
  }

  Widget _profile(BuildContext context) {
    return BlocBuilder<PetProfileCubit, PetProfileState>(
      builder: (context, state) {
        final PetProfileCubit manager = context.read<PetProfileCubit>();
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
                      MainStrings.viewProfileBodyTitles[index],
                      index,
                      manager,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: MainStrings.viewProfileBodyTitles.length,
                  ),
                ),
                profileBody(
                  context,
                  pet,
                  manager.currentProfileSection,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget profileBody(BuildContext context, Pet pet, int index) {
    return switch (index) {
      0 => AddNewPetProfile(pet: pet).profile(context, pet, canEdit: false),
      1 => const HealthPetProfile(),
      2 => const NutritionPetProfile(),
      3 => const ActivitiesPetProfile(),
      _ => SizedBox.shrink(),
    };
  }

  Widget __infoListItem(
    BuildContext context,
    String title,
    int index,
    PetProfileCubit manager,
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
