import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/pages/empty_profile.dart';
import 'package:pet_app/features/profile/presentation/pages/home_page_profile.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';
import 'package:pet_app/features/profile/presentation/widgets/drawer.dart';

class HomePageManager extends StatelessWidget {
  const HomePageManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        ProfileSetupCubit manager = ProfileSetupCubit.get(context);
        return AdvancedPetDrawer(
          controller: manager,
          scaffold: Scaffold(
            appBar: twoTitleAppbar(
              context: context,
              leading: GestureDetector(
                onTap: manager.drawerScaffoldKey.showDrawer,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: SharedModeColors.grey500,
                    child: const Icon(Icons.person),
                  ),
                ),
              ),
              title: 'Hello, ',
              titleAlignment: CrossAxisAlignment.start,
              boldTitle: false,
              boldSubTitle: true,
              subTitle: 'User',
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.search),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                    color: ThemeManager.currentTheme == ThemeState.lightTheme
                        ? SharedModeColors.black
                        : SharedModeColors.white,
                  ))),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: manager.drawerScaffoldKey.showDrawer,
                    child: const Icon(Icons.menu),
                  ),
                ),
              ],
            ),
            body: manager.numberOfPets != 0
                ? const HomePageProfile()
                : const EmptyProfileStartUp(),
          ),
        );
      },
    );
  }
}
