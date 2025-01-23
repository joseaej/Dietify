import 'package:flutter/material.dart';

class Macros extends ChangeNotifier {
  final int currentCalories;
  final int totalCalories;
  final double percentage;
  final MacroDetail fats;
  final MacroDetail protein;
  final MacroDetail carbs;

  Macros({
    required this.currentCalories,
    required this.totalCalories,
    required this.percentage,
    required this.fats,
    required this.protein,
    required this.carbs,
  });
   Macros.defaultValues()
      : currentCalories = 1850,
        totalCalories = 2200,
        percentage = 84,
        fats = MacroDetail(amount: "80", label: "fats", percentage: "80%"),
        protein = MacroDetail(amount: "80", label: "protein", percentage: "80%"),
        carbs = MacroDetail(amount: "80", label: "carbs", percentage: "80%");

  int getCurrentCalories(){
    return currentCalories;
  }
}

class MacroDetail {
  final String amount;
  final String label;
  final String percentage;

  MacroDetail({
    required this.amount,
    required this.label,
    required this.percentage,
  });
}

