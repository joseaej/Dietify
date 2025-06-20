import 'package:dietify/domain/models/achievements.dart';
import 'package:flutter/material.dart';
import '../../data/service/notification_service.dart';
import '../../data/service/shared_preference_service.dart';

class AchievementsProvider with ChangeNotifier {
  int achivementsCount = 0;
  List<Achievements> achievements = [
    Achievements(
        title: '¡Tutorial Superado!',
        description:
            'Completa tu primer entrenamiento. El camino comienza aquí.',
        currentPercent: 0,
        maxPercent: 1,
        isAchievementCompleted: false),
    Achievements(
        title: 'Modo Hidratado ON',
        description: 'Bebe 2L de agua en un solo día. ¡Como un verdadero pro!',
        currentPercent: 0,
        maxPercent: 2,
        isAchievementCompleted: false),
    Achievements(
        title: 'El placer de la vida',
        description: 'Añade 3 comidas en tu dia',
        currentPercent: 0,
        maxPercent: 3,
        isAchievementCompleted: false),
    Achievements(
        title: 'Racha Perfecta',
        description: 'Completa 20 entrenamientos',
        currentPercent: 0,
        maxPercent: 20,
        isAchievementCompleted: false),
    Achievements(
        title: 'Mas duro que el Acero',
        description:
            'Completa un entrenamiento de alta intensidad. ¡A sudar se ha dicho!',
        currentPercent: 0,
        maxPercent: 1,
        isAchievementCompleted: false),
    Achievements(
        title: 'Guardar es Ganar',
        description:
            'Guarda 10 entrenamientos en tu perfil. ¡Tu biblioteca de fitness crece!',
        currentPercent: 0,
        maxPercent: 10,
        isAchievementCompleted: false),
  ];
  AchievementsProvider() {
    loadAchievements();
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

  void saveAchievements() {
    SharedPreferenceService.saveAchievements(achievements);
    notifyListeners();
  }

  void loadAchievements() async {
    final loaded = await SharedPreferenceService.loadAchievements();
    if (loaded.isNotEmpty) {
      achievements = loaded;
      notifyListeners();
    }
  }

  void clearAchievements() {
    SharedPreferenceService.clearAchievements(achievements);
    notifyListeners();
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
