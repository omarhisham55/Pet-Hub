import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/core/utils/strings.dart';

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
