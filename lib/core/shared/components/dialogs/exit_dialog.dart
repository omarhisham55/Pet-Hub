import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';

Future<void> showExitDialog({
  required BuildContext context,
  required String title,
  String? content,
  TextAlign? titleAlign,
  required Function() onAgreeClick,
}) async {
  await showAdaptiveDialog(
    context: context,
    builder: (context) => ExitDialog(
      title: title,
      content: content,
      titleAlign: titleAlign,
      onAgreeClick: onAgreeClick,
    ),
  );
}

class ExitDialog extends StatelessWidget {
  final String title;
  final String? content;
  final TextAlign? titleAlign;
  final Function() onAgreeClick;
  const ExitDialog({
    super.key,
    required this.title,
    required this.onAgreeClick,
    this.titleAlign,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: titleAlign,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: content != null
          ? Text(content!, style: Theme.of(context).textTheme.bodyMedium)
          : null,
      actions: [
        Row(
          children: [
            Expanded(
              child: GlobalButton(
                  text: MainStrings.cancel,
                  color: SharedModeColors.red500,
                  onPressed: () => Constants.pop(context)),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: GlobalButton(
                    text: MainStrings.yes, onPressed: onAgreeClick)),
          ],
        ),
      ],
    );
  }
}
