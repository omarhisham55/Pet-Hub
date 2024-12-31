import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/utils/colors.dart';

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
