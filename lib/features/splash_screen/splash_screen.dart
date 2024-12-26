import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/shared/constants/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _initializeAuthGate);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initializeAuthGate() async {
    final bool isAuthenticated = await AuthGateChecks.isAuthenticatedCheck();
    final bool isOnBoardingComplete =
        await AuthGateChecks.isOnBoardingCompleteCheck();
    if (isOnBoardingComplete && isAuthenticated) {
      Constants.replaceWith(context, Routes.homePageProfile);
    } else {
      Constants.replaceWith(context, Routes.onBording);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Image.asset(SplashImages.logo)),
              Expanded(
                flex: 2,
                child: Lottie.asset(LoadingLotties.walkingDog),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
