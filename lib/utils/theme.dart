// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Paleta de colores
const Color background = Color.fromARGB(255, 29, 29, 31);
const Color backgroundTextField = Color.fromARGB(255, 34, 34, 37);
const Color font = Colors.white;
const Color orange = Color.fromARGB(255, 229, 154, 43);
const Color lightBackground = Color.fromARGB(255, 255, 255, 255);
const Color lightText = Color(0xFF000000);
const Color darkText = Colors.white;
const Color accentColor = Color(0xFFFF6F00);
const Color lightPrimary = Color(0xFF007BFF);
const Color darkPrimary = Color(0xFF1E88E5);
const Color errorColor = Color(0xFFD32F2F);
const Color successColor = Color(0xFF4CAF50);
const Color warningColor = Color(0xFFFFC107);

// Tema claro
ThemeData lightTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 0, 0, 0),
    scaffoldBackgroundColor: lightBackground,
    hintColor: Colors.grey[600],
    primaryColorDark: Colors.blueGrey[700],
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: lightText),
      bodyMedium: TextStyle(color: Colors.grey[800]),
      headlineMedium: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: lightText),
      titleTextStyle: TextStyle(
          color: lightText, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color.fromARGB(255, 0, 0, 0),
      textTheme: ButtonTextTheme.primary,
    ),
    switchTheme: _switchTheme);

// Tema oscuro
ThemeData darkTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 255, 255, 255),
    scaffoldBackgroundColor: background,
    hintColor: background,
    primaryColorDark: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: darkText),
      bodyMedium: TextStyle(color: Colors.grey[300]),
      headlineMedium: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      iconTheme: IconThemeData(color: darkText),
      titleTextStyle:
          TextStyle(color: darkText, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color.fromARGB(255, 255, 255, 255),
      textTheme: ButtonTextTheme.primary,
    ),
    switchTheme: _switchTheme);

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
