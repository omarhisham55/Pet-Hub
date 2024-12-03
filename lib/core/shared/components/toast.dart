import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_app/core/shared/constants/enums.dart';

void showToast({
  required String text,
  required ToastStates state,
  Toast? toastLength,
  ToastGravity? gravity,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: toastLength ?? Toast.LENGTH_LONG,
    gravity: gravity ?? ToastGravity.TOP,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
