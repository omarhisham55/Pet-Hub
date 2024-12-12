import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/bottom_nav_bar.dart';
import 'package:pet_app/features/profile/presentation/widgets/drawer.dart';

class HomePageManager extends StatelessWidget {
  const HomePageManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        final ProfileSetupCubit cubit = context.read<ProfileSetupCubit>();
        return AdvancedPetDrawer(
          controller: cubit,
          scaffold: Scaffold(
            appBar: TwoTitleAppbar(
              leading: GestureDetector(
                onTap: cubit.drawerScaffoldKey.showDrawer,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: SharedModeColors.grey500,
                    child: const Icon(Icons.person),
                  ),
                ),
              ),
              title: cubit.user?.name == null
                  ? ''
                  : MainStrings.hello('\n${cubit.user?.capName}'),
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
                    color: ThemeManager.currentTheme == ThemeState.lightTheme
                        ? SharedModeColors.black
                        : SharedModeColors.white,
                  ))),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: cubit.drawerScaffoldKey.showDrawer,
                    child: const Icon(Icons.menu),
                  ),
                ),
              ],
            ),
            body: cubit.user == null
                ? Lottie.asset(LoadingLotties.paws)
                : cubit.pages[cubit.currentBottomSheetIndex],
            bottomNavigationBar: const BottomNavBar(),
          ),
        );
      },
    );
  }
}
