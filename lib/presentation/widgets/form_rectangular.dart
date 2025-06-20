import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

Widget formRectangular(
  String hintText,
  String labelText,
  TextEditingController controller, {
  Color cursorColor = blue,
  Function()? onIconPressed,
  Icon? icon,
  Color backgroundColor = lightBackground,
  Color textColor = darkfont,
  String? Function(String?)? validator,
  String? Function(String?)? onSave,
}) {
  return TextFormField(
    autocorrect: true,
    controller: controller,
    cursorColor: cursorColor,
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
      border: const OutlineInputBorder(),
      suffixIcon: icon != null
          ? IconButton(
              icon: icon,
              onPressed: onIconPressed,
            )
          : null,
    ),
    maxLines: 1,
    validator: validator, 
    onSaved: onSave,
  );
}