import 'package:Dietify/models/goals.dart';
import 'package:flutter/material.dart';

class Macros extends ChangeNotifier {
  int currentCalories;
  int totalCalories;
  double percentage;
  MacroDetail fats;
  MacroDetail protein;
  MacroDetail carbs;
  double wheaterIntake;
  Goals goals;

  Macros({
    required this.currentCalories,
    required this.totalCalories,
    required this.percentage,
    required this.fats,
    required this.protein,
    required this.carbs,
    required this.wheaterIntake,
    required this.goals,
  });
   Macros.defaultValues()
      : currentCalories = 1850,
        totalCalories = 2200,
        percentage = 84,
        fats = MacroDetail(amount: "80", label: "fats", percentage: "80%"),
        protein = MacroDetail(amount: "80", label: "protein", percentage: "80%"),
        carbs = MacroDetail(amount: "80", label: "carbs", percentage: "80%"),
        wheaterIntake = 2.5,
        goals = Goals(waterGoal: 2.5, sleepGoal: 8);

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

