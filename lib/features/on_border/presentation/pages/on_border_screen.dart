import 'package:flutter/material.dart';
import 'package:pet_app/config/preferences/shared_preferences.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/on_border/presentation/cubit/on_border_cubit.dart';
import 'package:pet_app/features/profile/presentation/pages/home_page_manager.dart';

class OnBorderScreen extends StatefulWidget {
  const OnBorderScreen({super.key});

  @override
  State<OnBorderScreen> createState() => _OnBorderScreenState();
}

class _OnBorderScreenState extends State<OnBorderScreen> {
  @override
  void initState() {
    super.initState();
    newUserCheck() ? null : OnBorderCubit.get(context).initBottomsheet(context);
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: newUserCheck()
          ? const HomePageManager()
          : Hero(
              tag: 'dogBG',
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  SplashImages.background,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
    );
  }
}
