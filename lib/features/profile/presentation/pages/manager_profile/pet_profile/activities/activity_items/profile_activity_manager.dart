import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';

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
      appBar: TwoTitleAppbar(
        title: 'Pet Profile',
        subTitle: subTitle,
        boldTitle: false,
        boldSubTitle: true,
        titleAlignment: CrossAxisAlignment.start,
      ),
      body: body,
    );
  }
}

class ProfileActivityArguments {
  final String subTitle;
  final Widget body;

  ProfileActivityArguments({required this.subTitle, required this.body});
}
