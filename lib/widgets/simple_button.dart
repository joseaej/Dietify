import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';

Widget simpleButton(String text, Function onPressed, {Color? textcolor = Colors.white, Color buttoncolor = orange, Size? size}) {
  return ElevatedButton(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all<Size>(size ?? Size(88, 36)),
      backgroundColor: WidgetStateProperty.all<Color>(buttoncolor),
      foregroundColor: WidgetStateProperty.all<Color>(textcolor!),
    ),
    onPressed: () => onPressed(),
    child: Text(text, style: TextStyle(color: textcolor)),
  );
}