import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/utils/colors.dart';

class GlobalTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isObscured;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final Widget? suffix;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final TextInputType? keyboardType;

  const GlobalTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscured = false,
    this.validator,
    this.onFieldSubmitted,
    this.suffix,
    this.focusNode,
    this.textAlign = TextAlign.left,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: isObscured!,
      onEditingComplete: onEditingComplete,
      textAlign: textAlign,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: SharedModeColors.grey500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: SharedModeColors.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: SharedModeColors.blue500),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: SharedModeColors.yellow500),
        ),
        suffixIcon: suffix,
      ),
      validator: validator,
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  const TextWithIcon({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                icon,
                color: SharedModeColors.white,
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}


Widget shadedDivider() {
  return Divider(
    height: 50,
    color: SharedModeColors.grey200,
    thickness: 1,
  );
}

Widget textSnap({
  required BuildContext context,
  required String text,
  required String snapText,
  TextStyle? textStyle,
  TextStyle? snapTextStyle,
}) {
  return Row(
    children: [
      Text(
        text,
        style: textStyle ?? Theme.of(context).textTheme.titleMedium,
      ),
      Text(
        snapText,
        style: snapTextStyle ?? Theme.of(context).textTheme.titleMedium,
      ),
    ],
  );
}

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ModedContainer(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 10),
          Column(
            children: [
              const Text('09.06.2023 | 09:30'),
              Row(
                children: [
                  const Icon(Icons.directions_run_rounded),
                  Text(
                    'Morning Walk',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget settingSwitch({
  required bool value,
  required Function(bool)? onChanged,
}) {
  return Switch(
    value: value,
    onChanged: onChanged,
    thumbColor: WidgetStatePropertyAll(SharedModeColors.white),
    trackOutlineWidth: const WidgetStatePropertyAll(0),
    trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    inactiveTrackColor: SharedModeColors.grey300,
    activeTrackColor: SharedModeColors.blue500,
  );
}

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
  }
}
