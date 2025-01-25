import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';

Widget formRectangular(String hintText, String labelText, TextEditingController controller, {Color cursorColor = orange}) {
  return TextFormField(
        controller: controller,
        cursorColor: orange,
        decoration: InputDecoration(
          label: Text(
            labelText,
            style: TextStyle(color: darkfont),
          ),
          hintText: hintText,
          filled: true,
          fillColor: lightBackground,
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