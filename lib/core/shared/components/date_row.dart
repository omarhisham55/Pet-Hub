import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';

class DateRow extends StatelessWidget {
  final BuildContext context;
  final String title;
  final IconData icon;
  final String date;
  final String suffix;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? margin;
  const DateRow({
    super.key,
    required this.context,
    required this.title,
    required this.icon,
    required this.date,
    required this.suffix,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
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
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w300, color: textColor),
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: textColor),
                  ),
                ],
              ),
            ),
            Text(
              suffix,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
