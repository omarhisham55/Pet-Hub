import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/bottom_sheets/base_bottom_sheet.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/onbording/presentation/cubit/on_bording_cubit.dart';

Widget onBoardingBuilder(BuildContext context, [bool? isDesktop = false]) {
  return PopScope(
    canPop: false,
    child: BaseBottomSheet(
      context: context,
      manager: OnBordingCubit.get(context),
      icon: Icons.keyboard_double_arrow_left,
      title: OnBoardingStrings.boardingTitle,
      subTitle: OnBoardingStrings.boardingcontent,
      buttonText: RegistrationStrings.getStarted,
      // underButtonText: '',
      // underButtonTextButton: 'Sign up later',
      // underButtonTextButtonColor: SharedModeColors.grey500,
      // underButtonAction: () =>
      //     OnBordingCubit.get(context).finishOnBoarding(context),
      buttonAction: () => isDesktop!
          ? OnBordingCubit.get(context).toggleWidget()
          : OnBordingCubit.get(context).changeOnBorder(
              context,
              createAccountBuilder(context),
            ),
    ),
  );
}

Widget createAccountBuilder(BuildContext context) {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  return BlocBuilder<OnBordingCubit, OnBordingState>(
    builder: (context, state) {
      final manager = context.read<OnBordingCubit>();
      return GestureDetector(
        onTap: () {
          emailFocusNode.unfocus();
          passwordFocusNode.unfocus();
        },
        child: BaseBottomSheet(
          context: context,
          manager: manager,
          isLoading: manager.state is AuthLoading,
          icon: Icons.person_4_outlined,
          title: RegistrationStrings.createAccount,
          subTitle: RegistrationStrings.welcome,
          child: BlocBuilder<OnBordingCubit, OnBordingState>(
            builder: (context, state) {
              return Form(
                key: manager.createAccountFormKey,
                child: Column(
                  children: [
                    GlobalTextField(
                      hintText: RegistrationStrings.emailHintText,
                      controller: manager.emailController,
                      focusNode: emailFocusNode,
                      onEditingComplete: FocusScope.of(context).nextFocus,
                      validator: (value) => value!.isEmpty
                          ? RegistrationStrings.emailValidatorText
                          : null,
                    ),
                    BlocBuilder<OnBordingCubit, OnBordingState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GlobalTextField(
                            hintText: RegistrationStrings.passwordHintText,
                            controller: manager.passwordController,
                            focusNode: passwordFocusNode,
                            validator: (value) => value!.length < 6
                                ? RegistrationStrings.passwordValidatorText
                                : null,
                            isObscured: manager.isObscured,
                            suffix: IconButton(
                              onPressed: manager.changePassVisibility,
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
                        BlocBuilder<OnBordingCubit, OnBordingState>(
                            builder: (context, state) {
                          return Checkbox(
                            value: manager.checkbox,
                            onChanged: (value) => manager.checkBox(),
                            fillColor: state is AuthError &&
                                    state.message == 'unmarked checkbox'
                                ? WidgetStateProperty.all(
                                    SharedModeColors.red500)
                                : null,
                            side: BorderSide(color: SharedModeColors.grey200),
                          );
                        }),
                        const Text(RegistrationStrings.termsAndConditions),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          buttonText: RegistrationStrings.createAccount,
          underButtonText: RegistrationStrings.alreadyHaveAccount,
          underButtonTextButton: RegistrationStrings.loginHere,
          underButtonAction: () {},
          buttonAction: manager.login,
        ),
      );
    },
  );
}

// Widget activationCode(BuildContext context, OnBordingCubit manager) {
//   return BaseBottomSheet(
//     context: context,
//     manager: manager,
//     title: RegistrationStrings.validationTitle,
//     subTitle: RegistrationStrings.validationContent,
//     icon: Icons.qr_code,
//     child: BlocBuilder<OnBordingCubit, OnBordingState>(
//       builder: (context, state) {
//         return Row(
//           children: List.generate(
//             5,
//             (index) => Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 15, top: 5),
//                 child: GlobalTextField(
//                   hintText: '_',
//                   controller: manager.validationCodeController[index],
//                   textAlign: TextAlign.center,
//                   onChanged: (value) {
//                     if (value.length == 1) {
//                       debugPrint('value.length: ${value.length}');
//                       FocusScope.of(context).nextFocus();
//                     }
//                     if (value.isEmpty) {
//                       debugPrint('value: value');
//                       FocusScope.of(context).previousFocus();
//                     }
//                   },
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(1),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//     buttonText: 'Confirm',
//     buttonAction: () => manager.finishOnBoarding(context),
//     underButtonText: 'Did not receive the code? ',
//     underButtonTextButton: 'Resend',
//     underButtonAction: () {},
//   );
// }
