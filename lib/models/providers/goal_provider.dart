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

  Future<void> setGoals(Goal goal) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));
    this.goal = goal;
    _isLoading = false;
    notifyListeners();
  }

  void clearGoals() {
    goal = null;
    SharedPreferenceService.clearGoals();
    notifyListeners();
  }

  //updateo propiedades
  void updateWaterIntake(double waterInc){
    goal!.currentWaterIntake += waterInc;
    notifyListeners();
  }

  int getWaterPercent(){
    if (goal==null) return 0;
    double waterPercent = goal!.currentWaterIntake*100/goal!.maxWaterIntake!;
    return waterPercent.ceilToDouble().round();
  }

  void updateCalories(double calories,String oper){
    if (oper=="-") {
      goal!.currentCalories -= calories;
    }else{
      goal!.currentCalories += calories;
    }
    notifyListeners();
  }
}
