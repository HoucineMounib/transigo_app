import 'package:flutter/material.dart';

//////// In Error
///
void ErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      width: double.infinity,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      content: Text(message)));
}

/////////////in Secsses
///
///
void SucssesMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      width: double.infinity,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      content: Text(message)));
}
