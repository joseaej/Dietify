import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget numberInput(
  String hintText,
  String labelText,
  TextEditingController controller, {
  bool allowDecimal = false,
  Color cursorColor = blue,
  VoidCallback? onIconPressed,
  Icon? icon,
  Color backgroundColor = lightBackground,
  Color textColor = darkfont,
  String? Function(String?)? validator,
  void Function(String?)? onSave,
}) {
  return TextFormField(
    keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
    inputFormatters: [
      FilteringTextInputFormatter.allow(
        RegExp(allowDecimal ? r'^\d*\.?\d*' : r'\d+'),
      ),
    ],
    autocorrect: false,
    controller: controller,
    cursorColor: cursorColor,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: textColor),
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
