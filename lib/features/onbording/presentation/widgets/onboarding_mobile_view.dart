import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/toast.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/onbording/presentation/cubit/on_bording_cubit.dart';

class OnboardingMobileView extends StatelessWidget {
  const OnboardingMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    OnBordingCubit.get(context).initBottomsheet(context);
    return BlocListener<OnBordingCubit, OnBordingState>(
      listener: (context, state) {
        if (state is AuthError) {
          showToast(text: state.message, state: ToastStates.error);
        }
        if (state is AuthSuccess && state.user != null) {
          context
              .read<OnBordingCubit>()
              .finishOnBoarding(context, state.user!.id);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: FadeInDown(
          child: Container(
            margin: const EdgeInsets.only(bottom: 180),
            height: double.infinity,
            child: Image.asset(
              SplashImages.background,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
