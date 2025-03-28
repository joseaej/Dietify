import 'package:dietify/service/shared_preference_service.dart';
import 'package:flutter/material.dart';
import '../goals.dart';

class GoalProvider with ChangeNotifier {
  Goals? _goal;
  bool _isLoading = true;

  Goals? get goal => _goal;
  bool get isLoading => _isLoading;

  GoalProvider() {
    getGoalFromLocal();
  }

  Future<void> getGoalFromLocal() async {
    _isLoading = true;
    notifyListeners();

    _goal = await SharedPreferenceService.getGoalToLocal();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setGoalFromLocal() async {
    _isLoading = true;
    notifyListeners();
    if (_goal != null) {
      await SharedPreferenceService.setGoals(_goal!);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> setGoal(Goals goals) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    _goal = goals;
    _isLoading = false;
    notifyListeners();
  }

  void clearGoal() {
    _goal = Goals.defaultValue();
    notifyListeners();
  }
}
