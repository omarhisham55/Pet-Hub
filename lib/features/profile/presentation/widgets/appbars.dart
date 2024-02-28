import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

AppBar twoTitleAppbar({
  required BuildContext context,
  required String title,
  String? subTitle = '',
  Widget? leading,
  bool? centerTitle = false,
  TextStyle? titleStyle,
  TextStyle? subTitleStyle,
  List<Widget>? actions,
  double? elevation,
  CrossAxisAlignment? titleAlignment = CrossAxisAlignment.center,
}) =>
    AppBar(
      leading: leading,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: titleAlignment!,
        children: [
          Text(
            title,
            style: titleStyle ??
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: SharedModeColors.black,
                    ),
          ),
          if (subTitle!.isNotEmpty)
            Text(
              subTitle,
              style: subTitleStyle ?? Theme.of(context).textTheme.bodyMedium!,
            ),
        ],
      ),
      actions: actions,
      bottom: title == 'Add Pet Profile'
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
                  BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(24),
                            minHeight: 8,
                            value: ProfileSetupCubit.get(context)
                                    .setupPetProfileCurrentStep /
                                ProfileSetupCubit.get(context)
                                    .setupPetProfileMaxSteps,
                            color: SharedModeColors.yellow500,
                          ),
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
