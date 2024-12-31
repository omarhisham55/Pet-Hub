part of 'settings_bloc.dart';

class SettingsState {
  final bool? isDark;
  final bool isLocationAccess;
  final bool photoAccessSwitch;
  final bool appNoitfySwitch;
  final bool emailNotifySwitch;
  SettingsState({
    bool? isDark,
    this.isLocationAccess = false,
    this.photoAccessSwitch = false,
    this.appNoitfySwitch = false,
    this.emailNotifySwitch = false,
  }) : isDark = isDark ?? LocalSharedPreferences.isDarkTheme();

  SettingsState copyWith({
    bool? isDark,
    bool? isLocationAccess,
    bool? photoAccessSwitch,
    bool? appNoitfySwitch,
    bool? emailNotifySwitch,
  }) =>
      SettingsState(
        isDark: isDark ?? this.isDark,
        isLocationAccess: isLocationAccess ?? this.isLocationAccess,
        photoAccessSwitch: photoAccessSwitch ?? this.photoAccessSwitch,
        appNoitfySwitch: appNoitfySwitch ?? this.appNoitfySwitch,
        emailNotifySwitch: emailNotifySwitch ?? this.emailNotifySwitch,
      );
}
