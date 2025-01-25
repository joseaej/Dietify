import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';

Widget simpleButton(String text, Function onPressed, {Color? textcolor = Colors.white, Color buttoncolor = orange, Size? size}) {
  return ElevatedButton(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(size ?? Size(88, 36)),
      backgroundColor: MaterialStateProperty.all<Color>(buttoncolor),
      foregroundColor: MaterialStateProperty.all<Color>(textcolor!),
    ),
    onPressed: () => onPressed(),
    child: Text(text, style: TextStyle(color: textcolor)),
  );
}