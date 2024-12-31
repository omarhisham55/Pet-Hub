import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';

class GlobalButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? textColor;
  final Color? color;
  final TextStyle? style;
  final BorderSide? border;
  final bool expanded;
  const GlobalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.textColor = Colors.white,
    this.color,
    this.style,
    this.border = BorderSide.none,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin!,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: expanded ? double.infinity : null,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: border!,
        ),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
        color: color ?? SharedModeColors.blue500,
        child: Text(
          text,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: textColor),
        ),
      ),
    );
  }
}
