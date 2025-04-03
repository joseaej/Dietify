import 'package:dietify/models/goal.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:flutter/material.dart';

class GoalProvider with ChangeNotifier {
  Goal? goal;
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  GoalProvider() {
    getGoalsFromLocal();
  }
  //guardado local

  Future<void> getGoalsFromLocal() async {
    _isLoading = true;
    notifyListeners();

    goal = await SharedPreferenceService.getGoalsFromLocal();
    goal ??= Goal();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> savaGoalToLocal() async {
  Future<void> savaGoalToLocal() async {
    _isLoading = true;
    notifyListeners();
    if (goal != null) {
      await SharedPreferenceService.setGoalsFromLocal(goal!);
    }
    if (goal != null) {
      await SharedPreferenceService.setGoalsFromLocal(goal!);
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearGoals() {
    goal = null;
    SharedPreferenceService.clearGoals();
    notifyListeners();
  }

  //updateo propiedades
  void updateWaterIntake(double waterInc) {
    goal!.currentWaterIntake += waterInc;
    notifyListeners();
  }

  int getWaterPercent() {
    if (goal == null ||
        goal!.maxWaterIntake == null ||
        goal!.maxWaterIntake == 0) {
      return 0;
    }

    double waterPercent =
        (goal!.currentWaterIntake * 100) / goal!.maxWaterIntake!;
    return waterPercent.round();
  }
  int getCaloriesPrecent() {
    if (goal == null ||
        goal!.totalCalories == null ||
        goal!.totalCalories == 0) {
      return 0;
    }

    double totalCalories =
        (goal!.currentCalories * 100) / goal!.totalCalories!;
    return totalCalories.round();
  }

  void updateCalories(double calories, String oper) {
    if (oper == "-") {
      goal!.currentCalories -= calories;
    } else {
      goal!.currentCalories += calories;
    }
    notifyListeners();
  }


  @override
  String toString() {
    return "${goal!.currentCalories}\n${goal!.totalCalories}\n${goal!.maxWaterIntake}\n${goal!.currentWaterIntake}\n";
  }
}