import 'package:flutter/material.dart';

void displayError({required BuildContext context, required String message}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 5),
    showCloseIcon: true,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
