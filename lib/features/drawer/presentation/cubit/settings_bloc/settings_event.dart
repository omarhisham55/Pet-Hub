part of 'settings_bloc.dart';

sealed class SettingsEvent {}

final class DarkModeSwitchActionEvent extends SettingsEvent {
  final bool isDark;
  DarkModeSwitchActionEvent(this.isDark);
}

final class LocationAccessSwitchActionEvent extends SettingsEvent {
  final bool isLocationAccess;
  LocationAccessSwitchActionEvent(this.isLocationAccess);
}

final class PhoneAccessSwitchActionEvent extends SettingsEvent {
  final bool isPhoneAccess;
  PhoneAccessSwitchActionEvent(this.isPhoneAccess);
}

final class AppNotifySwitchActionEvent extends SettingsEvent {
  final bool isAppNotify;
  AppNotifySwitchActionEvent(this.isAppNotify);
}

final class EmailNotifySwitchActionEvent extends SettingsEvent {
  final bool isEmailNotify;
  EmailNotifySwitchActionEvent(this.isEmailNotify);
}
