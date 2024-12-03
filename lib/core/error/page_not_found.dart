import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(LoadingLotties.error),
            Text(
              MainStrings.undefinedRoute,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
