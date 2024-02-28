import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/on_border/presentation/cubit/on_border_cubit.dart';

Widget _defaultBottomsheet({
  required BuildContext context,
  required OnBorderCubit manager,
  required String title,
  required String subTitle,
  required IconData icon,
  required String buttonText,
  required Function() buttonAction,
  required Function() underButtonAction,
  required String underButtonText,
  Color? underButtonTextButtonColor,
  String? underButtonTextButton = '',
  Widget? child = const SizedBox(),
}) {
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
                  color: Theme.of(context).scaffoldBackgroundColor,
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
                    GlobalButton(
                      text: buttonText,
                      onPressed: buttonAction,
                      margin: const EdgeInsets.only(bottom: 10, top: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(underButtonText),
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
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Icon(icon),
              )
            ],
          ),
        );
      });
}

Widget onBoardingBuilder(BuildContext context) {
  return PopScope(
    canPop: false,
    child: _defaultBottomsheet(
      context: context,
      manager: OnBorderCubit.get(context),
      icon: Icons.keyboard_double_arrow_left,
      title: OnBoardingStrings.boardingTitle,
      subTitle: OnBoardingStrings.boardingcontent,
      buttonText: 'Get started',
      underButtonText: '',
      underButtonTextButton: 'Sign up later',
      underButtonTextButtonColor: SharedModeColors.grey500,
      underButtonAction: () => OnBorderCubit.get(context)
          .finishOnBoarding(context: context, signUpLater: true),
      buttonAction: () => OnBorderCubit.get(context).changeOnBorder(
        context,
        createAccountBuilder(
          context,
          OnBorderCubit.get(context),
        ),
      ),
    ),
  );
}

Widget createAccountBuilder(BuildContext context, OnBorderCubit manager) {
  return _defaultBottomsheet(
    context: context,
    manager: manager,
    icon: Icons.person_4_outlined,
    title: RegistrationStrings.createAccount,
    subTitle: RegistrationStrings.welcome,
    child: BlocBuilder<OnBorderCubit, OnBorderState>(
      builder: (context, state) {
        return Form(
          key: manager.createAccountFormKey,
          child: Column(
            children: [
              GlobalTextField(
                hintText: 'Your email',
                controller: manager.emailController,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                validator: (value) =>
                    value!.isEmpty ? 'Enter valid email' : null,
              ),
              BlocBuilder<OnBorderCubit, OnBorderState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GlobalTextField(
                      hintText: 'Password',
                      controller: manager.passwordController,
                      validator: (value) => value!.length < 6
                          ? 'Enter valid password: min 6 chars'
                          : null,
                      isObscured: manager.isObscured,
                      suffix: IconButton(
                        onPressed: () => manager.changePassVisibility(),
                        icon: Icon(
                          manager.isObscured
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  BlocBuilder<OnBorderCubit, OnBorderState>(
                      builder: (context, state) {
                    return Checkbox(
                      value: manager.checkbox,
                      onChanged: (value) => manager.checkBox(),
                      side: BorderSide(color: SharedModeColors.grey200),
                    );
                  }),
                  const Text('Accept Terms and Conditions'),
                ],
              ),
            ],
          ),
        );
      },
    ),
    buttonText: 'Create account',
    underButtonText: 'Already have an account? ',
    underButtonTextButton: 'Log in here!',
    underButtonAction: () {},
    buttonAction: () => manager.createAccountFormKey.currentState!.validate() &&
            manager.checkbox
        ? {
            manager.changeOnBorder(
              context,
              activationCode(context, manager),
            )
          }
        : null,
  );
}

Widget activationCode(BuildContext context, OnBorderCubit manager) {
  return _defaultBottomsheet(
    context: context,
    manager: manager,
    title: RegistrationStrings.validationTitle,
    subTitle: RegistrationStrings.validationContent,
    icon: Icons.qr_code,
    child: BlocBuilder<OnBorderCubit, OnBorderState>(
      builder: (context, state) {
        return Row(
          children: List.generate(
            5,
            (index) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 5),
                child: GlobalTextField(
                  hintText: '_',
                  controller: manager.validationCodeController[index],
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    if (value.length == 1) {
                      debugPrint('value.length: ${value.length}');
                      FocusScope.of(context).nextFocus();
                    }
                    if (value.isEmpty) {
                      debugPrint('value: value');
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
    buttonText: 'Confirm',
    buttonAction: () => manager.finishOnBoarding(context: context),
    underButtonText: 'Did not receive the code? ',
    underButtonTextButton: 'Resend',
    underButtonAction: () {},
  );
}
