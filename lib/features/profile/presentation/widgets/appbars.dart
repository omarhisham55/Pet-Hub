import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/presentation/cubit/add_pet_to_user_bloc.dart';

AppBar twoTitleAppbar({
  required BuildContext context,
  required String title,
  String subTitle = '',
  Widget? leading,
  bool? centerTitle = false,
  bool? boldTitle = true,
  bool? boldSubTitle = false,
  Color? lightColorTitle,
  Color? darkColorTitle,
  Color? lightColorSubTitle,
  Color? darkColorSubTitle,
  List<Widget>? actions,
  double? elevation,
  CrossAxisAlignment titleAlignment = CrossAxisAlignment.center,
}) =>
    AppBar(
      leading: leading,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: titleAlignment,
        children: [
          Text(
            title,
            style: subTitle.isEmpty
                ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: boldTitle! ? FontWeight.bold : null,
                      color: ThemeManager.currentTheme == ThemeState.lightTheme
                          ? lightColorTitle ?? SharedModeColors.black
                          : darkColorTitle ?? SharedModeColors.white,
                    )
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: boldTitle! ? FontWeight.bold : null,
                      color: ThemeManager.currentTheme == ThemeState.lightTheme
                          ? lightColorTitle ?? SharedModeColors.black
                          : darkColorTitle ?? SharedModeColors.white,
                    ),
          ),
          if (subTitle.isNotEmpty)
            Text(
              subTitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: boldSubTitle! ? FontWeight.bold : null,
                    color: ThemeManager.currentTheme == ThemeState.lightTheme
                        ? lightColorSubTitle ?? SharedModeColors.black
                        : darkColorSubTitle ?? SharedModeColors.white,
                  ),
            ),
        ],
      ),
      actions: actions,
      bottom: title == MainStrings.addPetProfile
          //Todo add loading percentage progress bar indicator instead
          ? PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 8,
                    decoration: BoxDecoration(
                      color: SharedModeColors.grey200,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  BlocBuilder<AddPetBloc, AddPetState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(24),
                          minHeight: 8,
                          value:
                              state.progress.order / AddPetStep.values.length,
                          color: SharedModeColors.yellow500,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : null,
    );

Widget drawerAppBar(context) => Row(
      children: [
        Text(
          'Your Pets',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: SharedModeColors.white,
              ),
        ),
      ],
    );

SliverAppBar contactAppbar(context) {
  return SliverAppBar(
    leading: IconButton(
      onPressed: () => Constants.pop(context),
      icon: Icon(
        Icons.adaptive.arrow_back,
        color: SharedModeColors.white,
      ),
    ),
    title: Text(
      'View Contact',
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: SharedModeColors.white),
    ),
    backgroundColor: SharedModeColors.blue100,
    flexibleSpace: Image.asset(
      ProfileImages.contactBg,
      fit: BoxFit.cover,
    ),
    // pinned: true,
    expandedHeight: 260,
  );
}
