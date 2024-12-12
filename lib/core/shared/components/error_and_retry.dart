import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/buttons/global_outlined_button.dart';
import 'package:pet_app/core/utils/strings.dart';

class ErrorWidgetAndRetry extends StatelessWidget {
  final String errorMessage;
  final Function() retryFunction;
  const ErrorWidgetAndRetry({
    super.key,
    required this.errorMessage,
    required this.retryFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(errorMessage),
        OutlinedGlobalButton(
          text: MainStrings.retry,
          onPressed: retryFunction,
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 140),
          padding: EdgeInsets.zero,
          borderRadius: 8,
        ),
      ],
    );
  }
}
