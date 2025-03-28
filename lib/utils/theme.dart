// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const Color background = Color.fromARGB(255, 29, 29, 31);
const Color backgroundBlack = Color.fromARGB(255, 21, 21, 22);
const Color backgroundTextField = Color.fromARGB(255, 34, 34, 37);
const Color font = Colors.white;
const Color lightGray = Color.fromARGB(255, 133, 133, 133);
const Color darkfont = Colors.black;
const Color orange = Color.fromARGB(255, 229, 154, 43);
const Color lightOrange = Color.fromARGB(255, 229, 152, 100);
const Color sliderOut = Color.fromARGB(255, 243, 178, 80);
const Color lightBackground = Color.fromARGB(255, 255, 255, 255);
const Color lightText = Color(0xFF000000);
const Color darkText = Colors.white;
const Color accentColor = Color(0xFFFF6F00);
const Color lightPrimary = Color(0xFF007BFF);
const Color darkPrimary = Color(0xFF1E88E5);
const Color errorColor = Color(0xFFD32F2F);
const Color successColor = Color(0xFF4CAF50);
const Color warningColor = Color(0xFFFFC107);
const Color iconColor = orange;
const Color borderColor = orange;
const Color focusBorderColor = orange;

// Tema claro
ThemeData lightTheme = ThemeData(
  primaryColor: Colors.black,
  scaffoldBackgroundColor: lightBackground,
  hintColor: Colors.grey[600],
  primaryColorDark: Colors.blueGrey[700],
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: lightText),
    bodyMedium: TextStyle(color: Colors.grey[800]),
    headlineMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black), // ICONOS NEGROS EN LIGHT
    titleTextStyle:
        TextStyle(color: lightText, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.black,
    textTheme: ButtonTextTheme.primary,
  ),
  switchTheme: _switchTheme,
  iconTheme: IconThemeData(color: Colors.black), // ICONOS NORMALES NEGROS
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          WidgetStateProperty.all(Colors.black), // ICONOS DE BOTONES NEGROS
    ),
  ),
);

// Tema oscuro
ThemeData darkTheme = ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: backgroundBlack, // Cambio para el fondo oscuro
  hintColor: background,
  primaryColorDark: Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: darkText),
    bodyMedium: TextStyle(color: Colors.grey[300]),
    headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: background,
    iconTheme: IconThemeData(color: Colors.white), // ICONOS BLANCOS EN DARK
    titleTextStyle:
        TextStyle(color: darkText, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white,
    textTheme: ButtonTextTheme.primary,
  ),
  switchTheme: _switchTheme,
  iconTheme: IconThemeData(color: Colors.white), // ICONOS NORMALES BLANCOS
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          WidgetStateProperty.all(Colors.white), // ICONOS DE BOTONES BLANCOS
    ),
  ),
);

SwitchThemeData get _switchTheme =>
    SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // Color del thumb cuando esta activado.
      }
      return Colors.grey; // Color del thumb cuando esta desactivado.
    }), trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.orange; // Color del track cuando esta activado.
      }
      return Colors.grey[400]; // Color del track cuando esta desactivado.
    }), thumbIcon: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return Icon(
            Icons.dark_mode,
            color: orange,
          ); //Icono cuando esta activado
        }
        return Icon(
          Icons.light_mode,
          color: orange,
        ); //Icono cuando esta desactivado
      },
    ));
