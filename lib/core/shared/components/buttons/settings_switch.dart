import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';

class SettingsSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const SettingsSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
}
