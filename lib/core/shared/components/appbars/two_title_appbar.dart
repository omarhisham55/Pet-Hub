import 'package:flutter/material.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/utils/colors.dart';

class TwoTitleAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final bool centerTitle;
  final bool boldTitle;
  final bool boldSubTitle;
  final double height;
  final Widget? leading;
  final Color? lightColorTitle;
  final Color? darkColorTitle;
  final Color? lightColorSubTitle;
  final Color? darkColorSubTitle;
  final List<Widget>? actions;
  final double? elevation;
  final CrossAxisAlignment? titleAlignment;
  final PreferredSizeWidget? bottom;
  const TwoTitleAppbar({
    super.key,
    required this.title,
    this.subTitle = '',
    this.centerTitle = false,
    this.boldTitle = true,
    this.boldSubTitle = false,
    this.height = 80,
    this.leading,
    this.lightColorTitle,
    this.darkColorTitle,
    this.lightColorSubTitle,
    this.darkColorSubTitle,
    this.actions,
    this.elevation,
    this.bottom,
    this.titleAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: titleAlignment!,
        children: [
          Text(
            title,
            style: subTitle.isEmpty
                ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: boldTitle ? FontWeight.bold : null,
                      color: ThemeManager.currentTheme == ThemeState.lightTheme
                          ? lightColorTitle ?? SharedModeColors.black
                          : darkColorTitle ?? SharedModeColors.white,
                    )
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: boldTitle ? FontWeight.bold : null,
                      color: ThemeManager.currentTheme == ThemeState.lightTheme
                          ? lightColorTitle ?? SharedModeColors.black
                          : darkColorTitle ?? SharedModeColors.white,
                    ),
          ),
          if (subTitle.isNotEmpty)
            Text(
              subTitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: boldSubTitle ? FontWeight.bold : null,
                    color: ThemeManager.currentTheme == ThemeState.lightTheme
                        ? lightColorSubTitle ?? SharedModeColors.black
                        : darkColorSubTitle ?? SharedModeColors.white,
                  ),
            ),
        ],
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
