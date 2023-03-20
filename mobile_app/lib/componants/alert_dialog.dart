import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, {required String message}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text("D'accord"),
        ),
      ],
    ),
  );
}
