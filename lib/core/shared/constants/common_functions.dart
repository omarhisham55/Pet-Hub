import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/core/utils/strings.dart';

bool isBase64(String str) {
  try {
    base64Decode(str);
    return true;
  } catch (e) {
    return false;
  }
}

String formatDateOrRelativeTime(int timestamp) {
  // Convert timestamp (in seconds) to DateTime
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final DateTime now = DateTime.now();

  final Duration difference = now.difference(dateTime);

  int monthsDifference =
      (now.year - dateTime.year) * 12 + now.month - dateTime.month;

  if (difference.inDays > 365) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    return 'from ${formatter.format(dateTime)}';
  } else if (monthsDifference > 0) {
    return '$monthsDifference month${monthsDifference > 1 ? 's' : ''} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'just now';
  }
}

void openBirthCalendar(
    BuildContext context, Function(List<String> items) onDone) async {
  late DateTime? date;
  String birthDate = '';
  String age = '';

  date = await showDatePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (date != null) {
    if (date.year != DateTime.now().year) {
      age = "${DateTime.now().year - date.year} ${MainStrings.ageYears(false)}";
    } else if (date.month != DateTime.now().month) {
      age =
          "${DateTime.now().month - date.month} ${MainStrings.ageMonths(false)}";
    } else {
      age = "${DateTime.now().day - date.day} ${MainStrings.ageDays(false)}";
    }
  }
  birthDate = DateFormat('d MMM yyyy').format(
    date ?? DateTime.now(),
  );
  onDone([age, birthDate]);
}

void openAdoptionCalendar(
    BuildContext context, Function(List<String> items) onDone) async {
  late DateTime? date;
  String? adoptionAge = '';
  String? adoptionDate = '';
  date = await showDatePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (date != null) {
    if (date.year != DateTime.now().year) {
      adoptionAge =
          "${DateTime.now().year - date.year} ${MainStrings.ageYears(true)}";
    } else if (date.month != DateTime.now().month) {
      adoptionAge =
          "${DateTime.now().month - date.month} ${MainStrings.ageMonths(true)}";
    } else {
      adoptionAge =
          "${DateTime.now().day - date.day} ${MainStrings.ageDays(true)}";
    }
  }
  adoptionDate = DateFormat('d MMM yyyy').format(
    date ?? DateTime.now(),
  );
  onDone([adoptionDate, adoptionAge]);
}

String generateId([int length = 20]) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

String weightKgAndLbs(int value, bool isKg) {
  if (isKg) {
    return '$value kg | ${(value * 2.20462).toStringAsFixed(2)} lbs';
  } else {
    return '${(value * 0.453592).toStringAsFixed(2)} kg | $value lbs';
  }
}

String priceCurrency(num value) {
  return value == value.toInt() ? '${value.round()} EGP' : '$value EGP';
}
