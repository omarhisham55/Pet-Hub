import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_app/core/utils/colors.dart';

class GlobalTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextStyle? style;
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
    this.style,
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
      style: style,
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
