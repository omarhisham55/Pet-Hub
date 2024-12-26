import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/constants/constants.dart';

class AppbarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Function()? onBack;
  final List<Widget>? actions;
  const AppbarWithBackButton({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          onBack!();
          Constants.pop(context);
        },
        icon: Icon(Icons.adaptive.arrow_back),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
