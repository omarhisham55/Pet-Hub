import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/onbording/presentation/widgets/bottomsheets.dart';

class OnboardingWebView extends StatefulWidget {
  const OnboardingWebView({super.key});

  @override
  State<OnboardingWebView> createState() => _OnboardingWebViewState();
}

class _OnboardingWebViewState extends State<OnboardingWebView>
    with SingleTickerProviderStateMixin {
  static AnimationController? _controller;
  static bool _showWidget1 = true;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    SplashImages.logo,
                    width: 200,
                  ),
                  Expanded(
                    child: Hero(
                      tag: Constants.dogBG,
                      child: Image.asset(
                        SplashImages.background,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: _controller!,
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 0),
                      end: Offset(0, 0),
                    ).animate(_controller!),
                    child: _showWidget1
                        ? onBoardingBuilder(context, true)
                        : createAccountBuilder(context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
