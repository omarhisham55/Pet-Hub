import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/preferences/shared_preferences.dart';
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
        return AdvancedDrawer(
          controller: ProfileSetupCubit.get(context).drawerScaffoldKey,
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
          child: Scaffold(
            appBar: twoTitleAppbar(
              context: context,
              leading: GestureDetector(
                onTap: () => ProfileSetupCubit.get(context)
                    .drawerScaffoldKey
                    .toggleDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: SharedModeColors.grey500,
                    child: const Icon(Icons.person),
                  ),
                ),
              ),
              title: 'Hello, ',
              subTitle: 'User',
              titleStyle: Theme.of(context).textTheme.bodyMedium,
              subTitleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeManager.currentTheme == ThemeState.lightTheme
                        ? SharedModeColors.black
                        : SharedModeColors.white,
                  ),
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
                    onTap: () {},
                    child: const Icon(Icons.menu),
                  ),
                ),
              ],
            ),
            body: LocalSharedPreferences.getLocalPreferences('profileSetUp')
                ? const HomePageProfile()
                : const EmptyProfileStartUp(),
          ),
        );
      },
    );
  }
}
