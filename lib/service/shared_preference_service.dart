import 'dart:convert';
import 'package:dietify/models/achievements.dart';
import 'package:dietify/models/goal.dart';
import 'package:dietify/models/profile.dart';
import 'package:dietify/models/settings.dart';
import 'package:dietify/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferences? _preferences;

  static Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Obtención del perfil
  static Future<void> setProfileFromLocal(Profile profile) async {
    await _initPreferences();
    await _preferences?.setString("profile", jsonEncode(profile.toMap()));
  }

  static Future<Profile?> getProfileFromLocal() async {
    await _initPreferences();
    final profileJson = _preferences?.getString("profile");
    if (profileJson == null) return null;
    return Profile.fromMap(jsonDecode(profileJson));
  }

  static Future<void> clearProfile() async {
    await _initPreferences();
    await _preferences?.remove("profile");
  }

  // Obtener ajustes de la app
  static Future<void> setSettings(Settings settings) async {
    await _initPreferences();
    await _preferences?.setString("settings", jsonEncode(settings.toMap()));
  }

  static Future<Settings?> getSettings() async {
    await _initPreferences();
    final settingsLocal = _preferences?.getString("settings");
    if (settingsLocal == null) return null;
    return Settings.fromMap(jsonDecode(settingsLocal));
  }

  static Future<void> clearSettings() async {
    await _initPreferences();
    _preferences?.remove("settings");
  }

  static Future<void> saveProfilePhotoPath(String path) async {
    await _initPreferences();
    await _preferences?.setString("profile_photo_path", path);
  }

  static Future<String?> getProfilePhotoPath() async {
    await _initPreferences();
    return _preferences?.getString("profile_photo_path");
  }

  //goals
  static Future<Goal?> getGoalsFromLocal() async {
    await _initPreferences();
    final goals = _preferences?.getString("goals");
    if (goals == null) return null;
    return Goal.fromMap(jsonDecode(goals));
  }

  static Future<void> setGoalsFromLocal(Goal goal) async {
    await _initPreferences();
    _preferences?.setString("goals", jsonEncode(goal.toMap()));
  }

  static Future<void> saveLastGoalDate(DateTime date) async {
    debugPrint(date.day.toString());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastGoalDate', date.toIso8601String());
  }

  static Future<DateTime?> getLastGoalDate() async {
    final prefs = await SharedPreferences.getInstance();
    String? dateStr = prefs.getString('lastGoalDate');
    if (dateStr != null) {
      debugPrint(DateTime.tryParse(dateStr)!.day.toString());
      return DateTime.tryParse(dateStr);
    }
    return null;
  }

  static void clearGoals() async {
    await _initPreferences();
    _preferences?.remove("goals");
  }

  //lastWorkout
  static Future<void> setLastWorkout(Workout workout) async {
    await _initPreferences();
    _preferences?.setString("lastWorkout", jsonEncode(workout.toMap()));
  }

  static Future<Workout?> getLastWorkout() async {
    await _initPreferences();
    final map = _preferences?.getString("lastWorkout");
    if (map == null) return null;
    return Workout.fromMap(jsonDecode(map));
  }

  static saveAchievements(List<Achievements> achievements) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> achievementsJson =
        achievements.map((a) => jsonEncode(a.toMap())).toList();
    debugPrint(achievementsJson.toString());
    await prefs.setStringList('achievements', achievementsJson);
  }

  static Future<List<Achievements>> loadAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? achievementsJson = prefs.getStringList('achievements');

    if (achievementsJson != null) {
      return achievementsJson
          .map((jsonStr) => Achievements.fromMap(jsonDecode(jsonStr)))
          .toList();
    } else {
      return [];
    }
  }

  static clearAchievements(List<Achievements> achievements) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("achievements");
  }
}
