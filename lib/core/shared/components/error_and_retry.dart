import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/core/shared/components/buttons/global_outlined_button.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';

class ErrorWidgetAndRetry extends StatelessWidget {
  final String errorMessage;
  final Function() retryFunction;
  final bool showErrorImg;
  final bool showRetryButton;
  const ErrorWidgetAndRetry({
    super.key,
    required this.errorMessage,
    required this.retryFunction,
    this.showErrorImg = false,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showErrorImg) Lottie.asset(LoadingLotties.error),
        Text(errorMessage),
        if (showRetryButton)
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
