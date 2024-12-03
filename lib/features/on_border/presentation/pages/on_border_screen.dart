import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_app/config/preferences/shared_preferences.dart';
import 'package:pet_app/config/responsive/responsive_manager.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/on_border/presentation/cubit/on_border_cubit.dart';
import 'package:pet_app/features/on_border/presentation/widgets/bottomsheets.dart';
import 'package:pet_app/features/profile/presentation/pages/home_page_manager.dart';

class OnBorderScreen extends StatefulWidget {
  const OnBorderScreen({super.key});

  @override
  State<OnBorderScreen> createState() => _OnBorderScreenState();

  static toggleWidget() {
    _OnBorderScreenState.toggleWidget();
  }
}

class _OnBorderScreenState extends State<OnBorderScreen>
    with SingleTickerProviderStateMixin {
  static AnimationController? _controller;
  static bool _showWidget1 = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {
      newUserCheck()
          ? null
          : OnBorderCubit.get(context).initBottomsheet(context);
    }
    if (Platform.isWindows || Platform.isMacOS) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  static void toggleWidget() {
    _showWidget1 = !_showWidget1;
    if (_showWidget1) {
      _controller?.reverse();
    } else {
      _controller?.forward();
    }
  }

  bool newUserCheck() {
    return LocalSharedPreferences.getLocalPreferences(
          SharedPreferencesKeys.onBoarderComplete,
        ) &&
        LocalSharedPreferences.getLocalPreferences(
          SharedPreferencesKeys.createAccountComplete,
        );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveManager(
      desktop: _desktop(context),
      mobile: _mobile(context),
    );
  }

  Widget _mobile(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: newUserCheck()
          ? const HomePageManager()
          : Hero(
              tag: 'dogBG',
              child: Container(
                margin: const EdgeInsets.only(bottom: 200),
                height: double.infinity,
                child: Image.asset(
                  SplashImages.background,
                  fit: BoxFit.contain,
                ),
              ),
            ),
    );
  }

  Widget _desktop(BuildContext context) {
    return Scaffold(
      body: newUserCheck()
          ? const HomePageManager()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(SplashImages.logo, width: 200,),
                        Expanded(
                          child: Hero(
                            tag: 'dogBG',
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
                              : createAccountBuilder(
                                  context,
                                  OnBorderCubit.get(context),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
