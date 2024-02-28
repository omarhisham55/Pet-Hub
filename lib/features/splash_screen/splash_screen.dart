import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/image_manager.dart';

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
    _timer = Timer(
      const Duration(seconds: 2),
      () => Constants.replaceWith(context, Routes.onBorder),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(SplashImages.logo),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Hero(
              tag: 'dogBG',
              child: Image.asset(
                SplashImages.background,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
