import 'package:bloc/bloc.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/config/theme/theme_manager.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<SettingsEvent>((event, emit) {
      return switch (event) {
        DarkModeSwitchActionEvent() => _darkModeSwitchAction(event, emit),
        LocationAccessSwitchActionEvent() =>
          _locationAccessSwitchAction(event, emit),
        PhoneAccessSwitchActionEvent() => _phoneAccessSwitchAction(event, emit),
        AppNotifySwitchActionEvent() => _appNotifySwitchAction(event, emit),
        EmailNotifySwitchActionEvent() => _emailNotifySwitchAction(event, emit),
      };
    });
  }

  void _darkModeSwitchAction(
    DarkModeSwitchActionEvent event,
    Emitter<SettingsState> emit,
  ) {
    event.isDark
        ? dpi<ThemeManager>().toggleTheme(ThemeEvent.darkTheme)
        : dpi<ThemeManager>().toggleTheme(ThemeEvent.lightTheme);
    emit(state.copyWith(isDark: event.isDark));
  }

  void _locationAccessSwitchAction(
    LocationAccessSwitchActionEvent event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(isLocationAccess: event.isLocationAccess));
  }

  void _phoneAccessSwitchAction(
    PhoneAccessSwitchActionEvent event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(photoAccessSwitch: event.isPhoneAccess));
  }

  void _appNotifySwitchAction(
    AppNotifySwitchActionEvent event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(appNoitfySwitch: event.isAppNotify));
  }

  void _emailNotifySwitchAction(
    EmailNotifySwitchActionEvent event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(emailNotifySwitch: event.isEmailNotify));
  }
}
