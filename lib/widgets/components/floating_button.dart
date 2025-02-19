import 'package:flutter/material.dart';

Widget floatingButton(Icon icon, Function() onPressed) {
  return FloatingActionButton(
    onPressed: onPressed,
    backgroundColor: Colors.orange,
    child: icon,
  );
}