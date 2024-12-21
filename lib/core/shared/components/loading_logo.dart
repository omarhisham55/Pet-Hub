import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/core/utils/image_manager.dart';

class LoadingLogo extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingLogo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        LoadingLotties.paws,
        width: width,
        height: height,
      ),
    );
  }
}
