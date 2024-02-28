import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';

class ProfileActivityManager extends StatelessWidget {
  final String subTitle;
  final Widget body;
  const ProfileActivityManager({
    super.key,
    required this.subTitle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoTitleAppbar(
          context: context,
          title: 'Pet Profile',
          subTitle: subTitle,
          titleStyle: Theme.of(context).textTheme.bodyMedium,
          subTitleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: SharedModeColors.black,
              ),
          titleAlignment: CrossAxisAlignment.start),
      body: body,
    );
  }
}

class ProfileActivityArguments {
  final String subTitle;
  final Widget body;

  ProfileActivityArguments({required this.subTitle, required this.body});
}
