import 'dart:convert';

import 'package:dietify/models/achievements.dart';
import 'package:dietify/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementsProvider with ChangeNotifier {
  int achivementsCount = 0;
  List<Achievements> achievements = [
    Achievements(
      title: '¡Tutorial Superado!',
      description: 'Completa tu primer entrenamiento. El camino comienza aquí.',
      currentPercent: 0,
      maxPercent: 1,
    ),
    Achievements(
      title: 'Modo Hidratado ON',
      description: 'Bebe 2L de agua en un solo día. ¡Como un verdadero pro!',
      currentPercent: 0,
      maxPercent: 2,
    ),
    Achievements(
      title: 'Mas duro que el Acero',
      description:
          'Completa un entrenamiento de alta intensidad. ¡A sudar se ha dicho!',
      currentPercent: 0,
      maxPercent: 1,
    ),
    Achievements(
      title: 'Guardar es Ganar',
      description:
          'Guarda 10 entrenamientos en tu perfil. ¡Tu biblioteca de fitness crece!',
      currentPercent: 0,
      maxPercent: 10,
    ),
  ];
  AchievementsProvider() {
    Future.microtask(() => loadAchievements());
  }
  Achievements? getAchievementByTitle(String title) {
    try {
      return achievements.firstWhere((a) => a.title == title);
    } catch (e) {
      return null;
    }
  }

  void sendAchievementNotification(Achievements achievement) {
    NotificationService notification = NotificationService();
    notification.initialize();
    notification.showNotification(
      id: achievement.hashCode,
      title: achievement.title,
      body: achievement.description,
    );
  }

  Future<void> saveAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> achievementsJson =
        achievements.map((a) => jsonEncode(a.toMap())).toList();
    await prefs.setStringList('achievements', achievementsJson);
  }

  Future<void> loadAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? achievementsJson = prefs.getStringList('achievements');

    if (achievementsJson != null) {
      achievements = achievementsJson
          .map((jsonStr) => Achievements.fromMap(jsonDecode(jsonStr)))
          .toList();
      notifyListeners();
    }
  }

  Future<void> updateAchievementProcess(Achievements achievement) async {
    final index = achievements.indexWhere((a) =>
        a.title == achievement.title &&
        a.description == achievement.description);
    if (index != -1) {
      achievements[index] = achievement;
      notifyListeners();
      saveAchievements();
    }
  }

  void addAchievement(Achievements achievement) {
    if (!achievements.contains(achievement)) {
      achievements.add(achievement);
      notifyListeners();
      sendAchievementNotification(achievement);
      saveAchievements();
    }
  }
}
