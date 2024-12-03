import 'package:flutter/material.dart';
import 'package:pet_app/config/responsive/responsive_manager.dart';
import 'package:pet_app/features/onbording/presentation/widgets/onboarding_mobile_view.dart';
import 'package:pet_app/features/onbording/presentation/widgets/onboarding_web_view.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveManager(
      desktop: OnboardingWebView(),
      mobile: OnboardingMobileView(),
    );
  }
}
