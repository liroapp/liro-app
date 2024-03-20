import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

showCustomToast(BuildContext context, String message, [Color? bgColor]) async {
  Flushbar(
    message: message,
    icon: const Icon(
      Icons.info,
      color: Colors.white,
    ),
    backgroundColor: bgColor ?? Colors.green,
    duration: const Duration(seconds: 4),
  ).show(context);
}
