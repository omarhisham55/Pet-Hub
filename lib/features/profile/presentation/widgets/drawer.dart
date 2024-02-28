import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 0,
        backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Pets',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: SharedModeColors.white,
                    ),
              ),
              BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          ProfileSetupCubit.get(context).numberOfPets + 1,
                      itemBuilder: (context, index) {
                        if (ProfileSetupCubit.get(context).numberOfPets == 0 ||
                            ProfileSetupCubit.get(context).numberOfPets ==
                                index) {
                          return _petItem(
                            context,
                            'add new',
                            () => Constants.navigateTo(
                              context,
                              Routes.addNewPetProfile,
                            ),
                            Icons.add,
                          );
                        }
                        return _petItem(
                          context,
                          'pet name',
                          () {
                            ProfileSetupCubit.get(context)
                                .changePetProfileView(0);
                            Constants.navigateTo(
                                context, Routes.viewPetProfile);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              const Divider(height: 50),
              const TextWithIcon(
                text: 'Dashboard',
                icon: Icons.dashboard_customize_outlined,
              ),
              TextWithIcon(
                text: 'Contacts',
                icon: Icons.contacts_outlined,
                onTap: () => Constants.navigateTo(context, Routes.contacts),
              ),
              TextWithIcon(
                text: 'Calendar',
                icon: Icons.calendar_today_rounded,
                onTap: () => Constants.navigateTo(context, Routes.calendar),
              ),
              const Divider(height: 50),
              const TextWithIcon(
                text: 'Account',
                icon: Icons.person_outlined,
              ),
              TextWithIcon(
                text: 'Settings',
                icon: Icons.settings_outlined,
                onTap: () => Constants.navigateTo(context, Routes.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _petItem(
    BuildContext context,
    String name,
    Function() onTap, [
    IconData icon = Icons.person,
  ]) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 30,
              child: Icon(icon),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: SharedModeColors.white,
                ),
          ),
        ],
      ),
    );
  }
}
