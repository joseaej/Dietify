// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class PasswordField extends StatefulWidget {
  final String? Function(String?)? validator;

  final TextEditingController controller;
  final String texto;
  final Icon icono;
  final BorderRadius borde;
  final EdgeInsets padding;

  const PasswordField({
    super.key,
    required this.controller,
    required this.texto,
    required this.icono,
    required this.borde,
    required this.padding,
    this.validator,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        cursorColor: blue,
        validator: widget.validator,
        decoration: InputDecoration(
          label: Text(
            widget.texto,
            style: TextStyle(color: darkfont),
          ),
          filled: true,
          fillColor: lightBackground,
          prefixIcon: widget.icono,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: widget.borde,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusBorderColor),
            borderRadius: widget.borde,
          ),
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        maxLines: 1,
      ),
    );
  }
}

Widget form(
    TextEditingController controller,
    String texto,
    Icon icono,
    BorderRadius borde,
    EdgeInsets padding,
    String? Function(String?)? validator,
    {required bool isPassword}) {
  if (isPassword) {
    return PasswordField(
      controller: controller,
      texto: texto,
      icono: icono,
      borde: borde,
      padding: padding,
    );
  } else {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: blue,
        validator: validator,
        decoration: InputDecoration(
          label: Text(
            texto,
            style: TextStyle(color: darkfont),
          ),
          filled: true,
          fillColor: lightBackground,
          prefixIcon: icono,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: borde,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusBorderColor),
            borderRadius: borde,
          ),
          border: OutlineInputBorder(),
        ),
        maxLines: 1,
      ),
    );
  }
}
