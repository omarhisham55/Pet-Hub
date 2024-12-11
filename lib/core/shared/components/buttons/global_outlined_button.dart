import 'package:flutter/material.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/utils/colors.dart';

class OutlinedGlobalButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? textColor;
  final Color? color;
  final TextStyle? style;
  final double borderRadius;
  final BorderSide? border;
  const OutlinedGlobalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.textColor,
    this.color,
    this.borderRadius = 14,
    this.style,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                color: ThemeManager.currentTheme == ThemeState.lightTheme
                    ? SharedModeColors.blue500
                    : SharedModeColors.white,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(15),
          child: Text(
            text,
            style: style ??
                Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: textColor),
          ),
        ),
      ),
    );
    /*   return GlobalButton(
      text: text,
      onPressed: onPressed,
      border: border ?? BorderSide(color: SharedModeColors.blue500),
      color: Colors.transparent,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: SharedModeColors.blue500),
      margin: margin,
      padding: padding,
      textColor: textColor,
    );
   */
  }
}
