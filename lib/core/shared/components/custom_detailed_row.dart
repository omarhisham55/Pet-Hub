import 'package:flutter/material.dart';

class CustomDetailedRow extends StatelessWidget {
  final MapEntry<String, String> value;
  const CustomDetailedRow({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value.key,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          value.value,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}
