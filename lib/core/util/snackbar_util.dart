import 'package:flutter/material.dart';

class SnackbarUtil {
  static void displayErrorMessage(
      {required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void displaySuccessMessage(
      {required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green[400],
      content: Text(message),
      duration: Duration(seconds: 3),
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
