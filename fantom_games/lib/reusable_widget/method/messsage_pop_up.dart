import 'package:flutter/material.dart';
import 'hex_string_to_color.dart';

void showMessagePopUp(BuildContext context, String message, String content, String hexcolor) {
  Color popUpColor = hexStringToColor(hexcolor);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message),
        content: Text(content),
        backgroundColor: popUpColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fermer', style: TextStyle(color: Colors.black)),
          ),
        ],
      );
    },
  );
}