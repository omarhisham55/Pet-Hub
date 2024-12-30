import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/features/home/presentation/cubit/navigation_cubit/navigation_cubit.dart';
import 'package:pet_app/features/home/presentation/widgets/drawer.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';

class NavigationManager extends StatelessWidget {
  const NavigationManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      builder: (context, navState) {
        return BlocSelector<PetProfileCubit, PetProfileState, String>(
          selector: (state) =>
              context.read<PetProfileCubit>().user?.capName ?? '',
          builder: (context, nameState) {
            final NavigationCubit navCubit = context.read<NavigationCubit>();
            return AdvancedPetDrawer(
              controller: navCubit.drawerScaffoldKey,
              scaffold: Scaffold(
                appBar: TwoTitleAppbar(
                  leading: GestureDetector(
                    onTap: navCubit.drawerScaffoldKey.showDrawer,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundColor: SharedModeColors.grey500,
                        child: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  title: MainStrings.hello('\n$nameState'),
                  titleAlignment: CrossAxisAlignment.start,
                  boldTitle: false,
                  boldSubTitle: true,
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.search),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                        color:
                            ThemeManager.currentTheme == ThemeState.lightTheme
                                ? SharedModeColors.black
                                : SharedModeColors.white,
                      ))),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: navCubit.drawerScaffoldKey.showDrawer,
                        child: const Icon(Icons.menu),
                      ),
                    ),
                  ],
                ),
                body: navCubit.pages[navState.index],
                bottomNavigationBar: const BottomNavBar(),
              ),
            );
          },
        );
      },
    );
  }
}
