import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pulse/core/theming/app_styles.dart';

void showToast({required String message, required Color color}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: TextStyles.font16semiBold.fontSize,
  );
}
