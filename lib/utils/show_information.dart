import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 3,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
