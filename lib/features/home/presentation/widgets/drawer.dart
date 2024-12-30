import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/domain/entities/pet.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';

class AdvancedPetDrawer extends StatelessWidget {
  final Scaffold scaffold;
  final AdvancedDrawerController controller;
  const AdvancedPetDrawer({
    super.key,
    required this.scaffold,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: controller,
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).drawerTheme.backgroundColor,
        ),
      ),
      drawer: const ProfileDrawer(),
      openScale: .8,
      openRatio: .6,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: scaffold,
    );
  }
}

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
                MainStrings.drawerYourPets,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: SharedModeColors.white,
                    ),
              ),
              BlocBuilder<PetProfileCubit, PetProfileState>(
                builder: (context, state) {
                  final cubit = context.read<PetProfileCubit>();
                  final int petsLength = cubit.user?.ownedPets.length ?? 0;
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: petsLength + 1,
                      itemBuilder: (context, index) {
                        final bool isLast =
                            petsLength == 0 || petsLength == index;
                        return _petItem(
                          context: context,
                          pet: !isLast ? cubit.user?.ownedPets[index] : null,
                          onTap: () {
                            isLast
                                ? Constants.navigateTo(
                                    context,
                                    Routes.addPetProfile,
                                  )
                                : {
                                    PetProfileCubit.get(context)
                                        .changePetProfileView(0),
                                    Constants.navigateTo(
                                      context,
                                      Routes.viewPetProfile,
                                      arguments: {
                                        'pet': cubit.user?.ownedPets[index]
                                      },
                                    ),
                                  };
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              const Divider(height: 50),
              ...MainStrings.drawerTitles.entries.map(
                (title) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title.key ==
                          MainStrings.drawerTitles.keys.toList()[3])
                        const Divider(height: 50),
                      TextWithIcon(
                        text: title.key,
                        icon: title.value,
                        onTap: () {
                          final route = _drawerActions(title);
                          if (route != null) {
                            Constants.navigateTo(context, route);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _drawerActions(MapEntry<String, IconData> title) {
    if (title.key == MainStrings.drawerTitles.keys.toList()[0])
      return null;
    else if (title.key == MainStrings.drawerTitles.keys.toList()[1])
      return Routes.contacts;
    else if (title.key == MainStrings.drawerTitles.keys.toList()[2])
      return Routes.calendar;
    else if (title.key == MainStrings.drawerTitles.keys.toList()[3])
      return null;
    else if (title.key == MainStrings.drawerTitles.keys.toList()[4])
      return Routes.settings;
    return null;
  }

  Widget _petItem({
    required BuildContext context,
    required Function() onTap,
    Pet? pet,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          ClipOval(
            child: GestureDetector(
              onTap: onTap,
              child: pet != null
                  ? ImageHandler(
                      imageBytes: pet.imgUrl,
                      width: 60,
                      height: 60,
                      color: SharedModeColors.grey300,
                    )
                  : Container(
                      child: Icon(Icons.add),
                      width: 60,
                      height: 60,
                      color: SharedModeColors.grey300,
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            pet?.name ?? MainStrings.drawerAddNew,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: SharedModeColors.white,
                ),
          ),
        ],
      ),
    );
  }
}
