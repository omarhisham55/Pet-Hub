import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class GlobalButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? textColor;
  final Color? color;
  final TextStyle? style;
  final BorderSide? border;
  const GlobalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.textColor = Colors.white,
    this.color,
    this.style,
    this.border = BorderSide.none,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin!,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: double.infinity,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: border!,
        ),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
        color: color ?? SharedModeColors.blue500,
        child: Text(
          text,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: textColor),
        ),
      ),
    );
  }
}

class OutlinedGlobalButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? textColor;
  final Color? color;
  final TextStyle? style;
  final BorderSide? border;
  const OutlinedGlobalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.textColor,
    this.color,
    this.style,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: ThemeManager.currentTheme == ThemeState.lightTheme
                    ? SharedModeColors.blue500
                    : SharedModeColors.white,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(15),
          child: Text(
            text,
            style: style ??
                Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: textColor),
          ),
        ),
      ),
    );
    /*   return GlobalButton(
      text: text,
      onPressed: onPressed,
      border: border ?? BorderSide(color: SharedModeColors.blue500),
      color: Colors.transparent,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: SharedModeColors.blue500),
      margin: margin,
      padding: padding,
      textColor: textColor,
    );
   */
  }
}

class GlobalTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isObscured;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final Widget? suffix;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final TextInputType? keyboardType;

  const GlobalTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscured = false,
    this.validator,
    this.onFieldSubmitted,
    this.suffix,
    this.focusNode,
    this.textAlign = TextAlign.left,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: isObscured!,
      onEditingComplete: onEditingComplete,
      textAlign: textAlign,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: SharedModeColors.grey500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: SharedModeColors.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: SharedModeColors.blue500),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: SharedModeColors.yellow500),
        ),
        suffixIcon: suffix,
      ),
      validator: validator,
    );
  }
}

Widget slideToContinueButton(BuildContext context, ProfileSetupCubit manager) {
  return Stack(
    children: [
      Container(
        key: manager.slideToContinueKey,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: SharedModeColors.blue100,
        ),
        child: Center(
          child: Text(
            'Swipe to continue',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: SharedModeColors.blue500),
          ),
        ),
      ),
      Draggable(
        axis: Axis.horizontal,
        onDragUpdate: (details) => details.globalPosition.dx > 340
            ? Constants.navigateTo(context, Routes.addPetProfile)
            : null,
        childWhenDragging: Container(),
        feedbackOffset: Offset.infinite,
        feedback: Container(
          margin: const EdgeInsets.all(6),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: SharedModeColors.blue500,
          ),
          child: Icon(
            Icons.keyboard_double_arrow_right_rounded,
            color: SharedModeColors.white,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(6),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: SharedModeColors.blue500,
          ),
          child: Icon(
            Icons.keyboard_double_arrow_right_rounded,
            color: SharedModeColors.white,
          ),
        ),
      ),
    ],
  );
}

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

class TextWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  const TextWithIcon({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                icon,
                color: SharedModeColors.white,
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}

Widget importantDatesRowItem({
  required BuildContext context,
  required String title,
  required IconData icon,
  required String date,
  required String suffix,
  Function()? onTap,
  Color? backgroundColor,
  EdgeInsets? margin,
}) {
  return Container(
    margin: margin ?? const EdgeInsets.all(20),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: backgroundColor ?? SharedModeColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: SharedModeColors.blue100,
            ),
            child: Icon(icon),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                Text(
                  date,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            suffix,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

class PetProfileWidgets {
  static Widget petOverview(BuildContext context, [bool canEdit = false]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CircleAvatar(
            radius: 70,
            child: Image.asset(ProfileImages.noProfileSetup),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Pet Name',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Visibility(
                  visible: canEdit,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: SharedModeColors.blue500),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text('Dog | '),
                Text('Border Collie'),
              ],
            ),
          ],
        )
      ],
    );
  }

  static Widget petDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appearance and distinctive signs',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Light brown with patches',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          detailRow(context, 'Gender', 'Male'),
          const Divider(),
          detailRow(context, 'Size', 'Medium'),
          const Divider(),
          detailRow(context, 'Weight', '6 kg'),
        ],
      ),
    );
  }

  static Widget importantTakes(BuildContext context) {
    ProfileSetupCubit manager = ProfileSetupCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Important Dates',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        importantDatesRowItem(
          context: context,
          icon: Icons.cake_outlined,
          title: 'Birthday',
          date: manager.birthDate,
          suffix: manager.petAge,
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.zero,
        ),
        const Divider(),
        importantDatesRowItem(
          context: context,
          icon: Icons.house_outlined,
          title: 'Adoption day',
          date: manager.adoptionDate,
          suffix: manager.petAdoptionAge,
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.zero,
        ),
      ],
    );
  }

  static Widget caretakers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Caretakers',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const CircleAvatar(
              radius: 25,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'caretaker name',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'caretaker email',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Widget detailRow(BuildContext context, String key, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        key,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      Text(
        value,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    ],
  );
}

Widget shadedDivider() {
  return Divider(
    height: 50,
    color: SharedModeColors.grey200,
    thickness: 1,
  );
}

Widget textSnap({
  required BuildContext context,
  required String text,
  required String snapText,
  TextStyle? textStyle,
  TextStyle? snapTextStyle,
}) {
  return Row(
    children: [
      Text(
        text,
        style: textStyle ?? Theme.of(context).textTheme.titleMedium,
      ),
      Text(
        snapText,
        style: snapTextStyle ?? Theme.of(context).textTheme.titleMedium,
      ),
    ],
  );
}

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ModedContainer(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 10),
          Column(
            children: [
              const Text('09.06.2023 | 09:30'),
              Row(
                children: [
                  const Icon(Icons.directions_run_rounded),
                  Text(
                    'Morning Walk',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget settingSwitch({
  required bool value,
  required Function(bool)? onChanged,
}) {
  return Switch(
    value: value,
    onChanged: onChanged,
    thumbColor: MaterialStatePropertyAll(SharedModeColors.white),
    trackOutlineWidth: const MaterialStatePropertyAll(0),
    trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
    inactiveTrackColor: SharedModeColors.grey300,
    activeTrackColor: SharedModeColors.blue500,
  );
}

class ModedContainer extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final double? borderRadius;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxBorder? border;
  final Color? lightThemeColor;
  final Color? darkThemeColor;
  final Color? selectedContainer;
  const ModedContainer({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = 16,
    this.height,
    this.margin,
    this.padding,
    this.border,
    this.lightThemeColor,
    this.darkThemeColor,
    this.selectedContainer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: margin ?? const EdgeInsets.all(10),
        padding: padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          border: border,
          color: selectedContainer ??
              (ThemeManager.currentTheme == ThemeState.lightTheme
                  ? lightThemeColor ?? SharedModeColors.white
                  : darkThemeColor ?? SharedModeColors.grey800),
        ),
        child: child,
      ),
    );
  }
}
