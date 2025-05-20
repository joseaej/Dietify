import 'package:dietify/models/goal.dart';
import 'package:dietify/service/notification_service.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:flutter/material.dart';

enum MacrosEnum { fat, carbs, protein }

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
    _isLoading = true;
    notifyListeners();
    if (goal != null) {
      await SharedPreferenceService.setGoalsFromLocal(goal!);
    }
    _isLoading = false;
    notifyListeners();
  }

  void clearGoals() {
    goal = Goal();
    SharedPreferenceService.clearGoals();
    notifyListeners();
  }

  //updateo propiedades
  void updateWaterIntake(double waterInc) {
    if (goal != null) {
      goal!.currentWaterIntake += waterInc;
      if (goal!.currentWaterIntake > (goal!.maxWaterIntake! + 1000)) {
        NotificationService notificationService = NotificationService();
        notificationService.initialize();
        notificationService.showNotification(
            title: "Demasiado agua por hoy",
            id: 3,
            body: "¡Cuidado es peligroso tomar demasiada agua!");
      }
      notifyListeners();
    }
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

    double totalCalories = (goal!.currentCalories * 100) / goal!.totalCalories!;
    return totalCalories.round();
  }

  void updateCalories(double calories, String oper) {
    if (oper == "-") {
      goal!.currentCalories -= calories;
    } else {
      goal!.currentCalories += calories;
      if (goal!.currentCalories > (goal!.totalCalories! + 5000)) {
        NotificationService notificationService = NotificationService();
        notificationService.initialize();
        notificationService.showNotification(
            title: "Demasiadas calorias",
            id: 5,
            body: "¡Cuidado con tomar demasiada calorias!");
      }
    }
    notifyListeners();
  }

  void updateMacro(MacrosEnum macrosEnum, double value) {
    if (goal != null) {
      switch (macrosEnum) {
        case MacrosEnum.fat:
          goal!.fat += value;
          break;
        case MacrosEnum.protein:
          goal!.protein += value;
          break;
        case MacrosEnum.carbs:
          goal!.carbs += value;
          break;
      }
    }
    notifyListeners();
  }

  void getMaxCarbs() {
    if (goal != null) {
      goal!.getMaxCarbs() ?? 0;
    }
  }

  void getMaxFats() {
    if (goal != null) {
      goal!.getMaxFats() ?? 0;
    }
  }

  void getMaxProtein(double weight) {
    if (goal != null) {
      goal!.getMaxProtein(weight);
    }
  }

  @override
  String toString() {
    return "${goal!.currentCalories}\n${goal!.totalCalories}\n${goal!.maxWaterIntake}\n${goal!.currentWaterIntake}\n";
  }
}
