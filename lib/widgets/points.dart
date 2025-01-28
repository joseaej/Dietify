import 'package:flutter/material.dart';

Widget points(Color firstColor, Color secondColor, Color thirdColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 20.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: firstColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      const SizedBox(width: 10.0),
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: secondColor,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 10.0),
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: thirdColor,
          shape: BoxShape.circle,
        ),
      ),
    ],
  );
}
