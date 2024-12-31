import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/buttons/settings_switch.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/drawer/presentation/cubit/settings_bloc/settings_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MainStrings.settings,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: MainStrings.settingsItems.entries
            .map((entry) => _buildSettingsSection(context, entry))
            .toList(),
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    MapEntry<String, Map<String, Map<String, dynamic>>> section,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.key,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ...section.value.entries
            .map((item) => _buildSettingItem(context, item))
            .toList(),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    MapEntry<String, Map<String, dynamic>> item,
  ) {
    return ModedContainer(
      child: Row(
        children: [
          ImageHandler(
            image: item.value['image'],
            height: 60,
            isAsset: true,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.key,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(item.value['subTitle']),
              ],
            ),
          ),
          item.value['action'] ?? _resolveActionWidget(item.key),
        ],
      ),
    );
  }

  Widget _resolveActionWidget(String key) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsBloc>();
        switch (key) {
          case 'Dark mode':
            return SettingsSwitch(
              value: state.isDark!,
              onChanged: (value) => cubit.add(DarkModeSwitchActionEvent(value)),
            );
          case 'Location access':
            return SettingsSwitch(
              value: state.isLocationAccess,
              onChanged: (value) =>
                  cubit.add(LocationAccessSwitchActionEvent(value)),
            );
          case 'Photo access':
            return SettingsSwitch(
              value: state.photoAccessSwitch,
              onChanged: (value) =>
                  cubit.add(PhoneAccessSwitchActionEvent(value)),
            );
          case 'App Notifications':
            return SettingsSwitch(
              value: state.appNoitfySwitch,
              onChanged: (value) =>
                  cubit.add(AppNotifySwitchActionEvent(value)),
            );
          case 'Email Notifications':
            return SettingsSwitch(
              value: state.emailNotifySwitch,
              onChanged: (value) =>
                  cubit.add(EmailNotifySwitchActionEvent(value)),
            );
          default:
            return Icon(Icons.adaptive.arrow_forward);
        }
      },
    );
  }
}
