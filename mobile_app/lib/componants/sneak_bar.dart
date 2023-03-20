import 'package:flutter/material.dart';

Future<void> showSneakBar(BuildContext context,
    {required String message, Color color = const Color(0xFFB50000)}) async {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  await Future.delayed(const Duration(seconds: 2));
}
