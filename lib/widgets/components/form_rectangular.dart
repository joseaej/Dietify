import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';

Widget formRectangular(
  String hintText,
  String labelText,
  TextEditingController controller, {
  Color cursorColor = orange,
  Function()? onIconPressed,
  Icon? icon,
  Color backgroundColor = lightBackground,
  Color textColor = darkfont
}) {
  return TextFormField(
    autocorrect: true,
    controller: controller,
    cursorColor: orange,
    decoration: InputDecoration(
      label: Text(
        labelText,
        style: TextStyle(color: textColor),
      ),
      hintText: hintText,
      filled: true,
      fillColor: backgroundColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusBorderColor),
      ),
      border: OutlineInputBorder(),
    ),
    maxLines: 1,
  );
}
