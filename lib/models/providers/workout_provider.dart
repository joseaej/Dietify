import 'package:dietify/models/repository/workout_repository.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:flutter/material.dart';

class WorkoutProvider with ChangeNotifier {
  Workout? lastWorkout;
  Workout randomWorkout = Workout();
  WorkoutProvider() {
    loadLastWorkout();
  }

  void updateLastWorkout(Workout? newLastWorkout) {
    lastWorkout = newLastWorkout;
    notifyListeners();
  }

  Future<void> getRandomWorkout()async {
    WorkoutRepository workoutRepository = WorkoutRepository();
    randomWorkout = await workoutRepository.getRandomWorkouts();
  }

  Future<void> loadLastWorkout() async {
    lastWorkout = await SharedPreferenceService.getLastWorkout();
    notifyListeners();
  }

  Future<void> saveLastWorkout() async {
    if (lastWorkout != null) {
      await SharedPreferenceService.setLastWorkout(lastWorkout!);
      notifyListeners();
    }
  }
}
