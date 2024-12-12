import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/onbording/presentation/cubit/on_bording_cubit.dart';

class BaseBottomSheet extends StatelessWidget {
  final BuildContext context;
  final OnBordingCubit manager;
  final String title;
  final String subTitle;
  final IconData icon;
  final String buttonText;
  final bool isLoading;
  final Function() buttonAction;
  final Function()? underButtonAction;
  final String? underButtonText;
  final Color? underButtonTextButtonColor;
  final String? underButtonTextButton;
  final Widget? child;
  const BaseBottomSheet({
    super.key,
    required this.context,
    required this.manager,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.buttonText,
    required this.buttonAction,
    this.isLoading = false,
    this.underButtonAction,
    this.underButtonText,
    this.underButtonTextButtonColor,
    this.underButtonTextButton,
    this.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      controller: manager.keyboardController,
      builder: (context, isKeyboardVisible) {
        return Padding(
          padding: manager.keyboardController.isVisible
              ? const EdgeInsets.only(bottom: 200)
              : EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomSheetTheme.backgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        subTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    child!,
                    isLoading
                        ? Lottie.asset(
                            LoadingLotties.paws,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : GlobalButton(
                            text: buttonText,
                            onPressed: buttonAction,
                            margin: const EdgeInsets.only(bottom: 10, top: 30),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (underButtonText != null) Text(underButtonText!),
                        if (underButtonTextButton != null)
                          GestureDetector(
                            onTap: underButtonAction,
                            child: Text(
                              underButtonTextButton!,
                              style: TextStyle(
                                color: underButtonTextButtonColor ??
                                    SharedModeColors.blue500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor:
                    Theme.of(context).bottomSheetTheme.backgroundColor,
                child: Icon(icon),
              )
            ],
          ),
        );
      },
    );
  }
}
