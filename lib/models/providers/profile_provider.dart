import 'package:dietify/models/repository/workout_repository.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:flutter/material.dart';
import '../profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _profile;
  bool _isLoading = true;
  final WorkoutRepository _repository = WorkoutRepository();
  List<Workout> savedWorkout = List.empty(growable: true);

  Profile? get profile => _profile;
  bool get isLoading => _isLoading;

  ProfileProvider() {
    getProfileFromLocal();
  }

  Future<void> getProfileFromLocal() async {
    _isLoading = true;
    notifyListeners();

    _profile = await SharedPreferenceService.getProfileFromLocal();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setProfile(Profile profile) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));
    _profile = profile;
    _isLoading = false;
    notifyListeners();
  }

  void updateEmail(String email) {
    if (_profile != null) {
      _profile = _profile!.copyWith(email: email);
      notifyListeners();
    }
  }

  void updateUsername(String username) {
    if (_profile != null) {
      _profile = _profile!.copyWith(username: username);
      notifyListeners();
    }
  }

  void updatePhotoUrl(String urlPhoto) {
    if (_profile != null) {
      _profile = _profile!.copyWith(urlPhoto: urlPhoto);
      notifyListeners();
    }
  }

  void updateWeight(double weight) {
    if (_profile != null) {
      _profile = _profile!.copyWith(weight: weight);
      notifyListeners();
    }
  }

  void updateHeight(double height) {
    if (_profile != null) {
      _profile = _profile!.copyWith(height: height);
      notifyListeners();
    }
  }

  void updateAge(int age) {
    if (_profile != null) {
      _profile = _profile!.copyWith(age: age);
      notifyListeners();
    }
  }

  void updateActivityLevel(String activityLevel) {
    if (_profile != null) {
      _profile = _profile!.copyWith(activityLevel: activityLevel);
      notifyListeners();
    }
  }

  void clearProfile() {
    _profile = null;
    notifyListeners();
  }

  //Guardar Workouts;
  Future<void> addWorkoutToList(Workout savedWorkout) async {
    await _repository.saveWorkoutToProfile(savedWorkout, profile!);
    notifyListeners();
  }

  Future<List<Workout>> getAllWorkoutsToProfile() async {
    if (profile != null) {
      final list = await _repository.getAllWorkoutsToProfile(profile!);
      if (list != null) {
        if (list.isNotEmpty) {
          return list;
        }
        return list;
      }
    }
    return List.empty();
  }
}
