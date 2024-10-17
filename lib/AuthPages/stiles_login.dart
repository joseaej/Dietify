import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    const BorderRadius inputBorder = BorderRadius.all(Radius.circular(8));

    return ThemeData(
      primaryColor: Colors.teal,
      hintColor: Colors.yellow,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyLarge: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        titleMedium: TextStyle(
          color: Colors.orange,
          shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.yellow.shade100,
        elevation: 5,
        margin: const EdgeInsets.only(top: 15),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Color(0xFFF5F5DC),
        contentPadding: EdgeInsets.all(16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.pinkAccent),
          overlayColor: WidgetStateProperty.all(Colors.purple.withOpacity(0.2)),
          elevation: WidgetStateProperty.all(9.0),
          shape: WidgetStateProperty.all(
            BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        error: Colors.deepOrange,
      ),
    );
  }
}
