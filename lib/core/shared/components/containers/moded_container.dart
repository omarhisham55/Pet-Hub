import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/utils/colors.dart';

class ModedContainer extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final double? borderRadius;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxBorder? border;
  final Color? lightThemeColor;
  final Color? darkThemeColor;
  final Color? selectedContainer;
  const ModedContainer({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = 16,
    this.height,
    this.margin,
    this.padding,
    this.border,
    this.lightThemeColor,
    this.darkThemeColor,
    this.selectedContainer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeManager, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            height: height,
            margin: margin ?? const EdgeInsets.all(10),
            padding: padding ?? const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius!),
              border: border,
              color: selectedContainer ??
                  (ThemeManager.currentTheme == ThemeState.lightTheme
                      ? lightThemeColor ?? SharedModeColors.white
                      : darkThemeColor ?? SharedModeColors.grey800),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
