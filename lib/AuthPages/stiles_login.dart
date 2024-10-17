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
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.purple.withOpacity(.1),
        contentPadding: EdgeInsets.zero,
        errorStyle: const TextStyle(
          backgroundColor: Colors.orange,
          color: Colors.white,
        ),
        labelStyle: const TextStyle(fontSize: 12),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
          borderRadius: inputBorder,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
          borderRadius: inputBorder,
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700, width: 7),
          borderRadius: inputBorder,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400, width: 8),
          borderRadius: inputBorder,
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 5),
          borderRadius: inputBorder,
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
