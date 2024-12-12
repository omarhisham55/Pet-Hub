import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';

class ContactSliverAppbar extends StatelessWidget {
  const ContactSliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Constants.pop(context),
        icon: Icon(
          Icons.adaptive.arrow_back,
          color: SharedModeColors.white,
        ),
      ),
      title: Text(
        'View Contact',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: SharedModeColors.white),
      ),
      backgroundColor: SharedModeColors.blue100,
      flexibleSpace: Image.asset(
        ProfileImages.contactBg,
        fit: BoxFit.cover,
      ),
      // pinned: true,
      expandedHeight: 260,
    );
  }
}
