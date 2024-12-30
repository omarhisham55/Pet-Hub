import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PetProfileCubit, PetProfileState>(
        builder: (context, state) {
          PetProfileCubit manager = PetProfileCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _personalisation(context, manager),
                  _access(context, manager),
                  _notifications(context, manager),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _personalisation(BuildContext context, PetProfileCubit manager) {
    return _settingItems(
      context: context,
      title: 'Personalisation',
      items: {
        'TimeZone': {
          'image': SettingsImages.timeZone,
          'subTitle': 'Choose your timezone',
          'action': Icon(Icons.adaptive.arrow_forward)
        },
        'Language': {
          'image': SettingsImages.language,
          'subTitle': 'Set the app language',
          'action': Icon(Icons.adaptive.arrow_forward)
        },
        'Dark mode': {
          'image': SettingsImages.darkMode,
          'subTitle': 'Choose view mode',
          'action': settingSwitch(
            value: manager.darkModeSwitch,
            onChanged: (value) => manager.darkModeSwitchAction(context),
          ),
        },
      },
    );
  }

  Widget _access(BuildContext context, PetProfileCubit manager) {
    return _settingItems(
      context: context,
      title: 'Access',
      items: {
        'Location access': {
          'image': SettingsImages.locationAccess,
          'subTitle': 'Access to your location',
          'action': settingSwitch(
            value: manager.locationAccessSwitch,
            onChanged: (value) => manager.locationAccessSwitchAction(),
          ),
        },
        'Photo access': {
          'image': SettingsImages.photoAccess,
          'subTitle': 'Access to your media',
          'action': settingSwitch(
            value: manager.photoAccessSwitch,
            onChanged: (value) => manager.phoneAccessSwitchAction(),
          ),
        },
      },
    );
  }

  Widget _notifications(BuildContext context, PetProfileCubit manager) {
    return _settingItems(
      context: context,
      title: 'Notifications',
      items: {
        'App Notifications': {
          'image': SettingsImages.appNotifications,
          'subTitle': 'Get push notifications',
          'action': settingSwitch(
            value: manager.appNoitfySwitch,
            onChanged: (value) => manager.appNotifySwitchAction(),
          ),
        },
        'Email Notifications': {
          'image': SettingsImages.emailNotifications,
          'subTitle': 'Get general updates',
          'action': settingSwitch(
            value: manager.emailNotifySwitch,
            onChanged: (value) => manager.emailNotifySwitchAction(),
          ),
        },
      },
    );
  }

  Widget _settingItems({
    required BuildContext context,
    required String title,
    required Map<String, dynamic> items,
  }) {
    Widget settingItem(
      BuildContext context,
      MapEntry item,
    ) {
      return ModedContainer(
        child: Row(
          children: [
            Image.asset(
              item.value['image'],
              height: 60,
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
            item.value['action']
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (items.isNotEmpty)
          ...List.generate(
            items.length,
            (index) => settingItem(context, items.entries.toList()[index]),
          ),
      ],
    );
  }
}
