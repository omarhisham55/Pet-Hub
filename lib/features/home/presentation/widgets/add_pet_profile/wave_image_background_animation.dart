import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';

class CircularAudioWave extends StatefulWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final Color? color;
  const CircularAudioWave({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color,
  });

  @override
  CircularAudioWaveState createState() => CircularAudioWaveState();
}

class CircularAudioWaveState extends State<CircularAudioWave>
    with TickerProviderStateMixin {
  List<AnimationController> animationControllers = [];
  List<Animation<double>> animations = [];
  List<double> circleSizes = [];

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    for (var controller in animationControllers) {
      controller.removeStatusListener((status) {});
      controller.dispose();
    }
    for (var controller in animations) {
      controller.removeStatusListener((status) {});
    }
    circleSizes = [];
    super.dispose();
  }

  void _startAnimation() {
    for (int i = 0; i < 5; i++) {
      Future.delayed(Duration(milliseconds: 400 * i), () {
        circleSizes.add(0);
        _animateCircle(i);
      });
    }
  }

  void _animateCircle(int index) {
    if (mounted) {
      late final AnimationController animationController;
      animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animationController.repeat();
          }
        });

      late final Animation<double> animation;
      animation = Tween<double>(begin: 0, end: 1).animate(animationController)
        ..addListener(() {
          setState(() {
            circleSizes[index] = animation.value;
          });
        });

      animationControllers.add(animationController);
      animations.add(animation);

      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        circleSizes.length,
        (index) => CircularWave(
          circleSize: circleSizes[index],
          height: widget.height,
          width: widget.width,
          color: widget.color,
          child: widget.child ?? Container(),
        ),
      ),
    );
  }
}

class CircularWave extends StatelessWidget {
  final double circleSize;
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;

  const CircularWave({
    Key? key,
    required this.circleSize,
    required this.child,
    this.height = 150,
    this.width = 150,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: WavePainter(circleSize: circleSize, color: color),
        child: child,
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double circleSize;
  final Color? color;

  WavePainter({required this.circleSize, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = color ?? SharedModeColors.grey200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final adjustedRadius = circleSize * radius;
    final path = Path()
      ..addOval(
        Rect.fromCircle(center: center, radius: adjustedRadius),
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
