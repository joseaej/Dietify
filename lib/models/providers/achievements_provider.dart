import 'package:dietify/models/achievements.dart';
import 'package:dietify/service/notification_service.dart';
import 'package:flutter/material.dart';

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
      title: 'Racha Imparable',
      description: 'Entrena durante 7 días seguidos. ¿Quién te para ahora?',
      currentPercent: 0,
      maxPercent: 7,
    ),
    Achievements(
      title: 'Modo Hidratado ON',
      description: 'Bebe 2L de agua en un solo día. ¡Como un verdadero pro!',
      currentPercent: 0,
      maxPercent: 2,
    ),
    Achievements(
      title: 'Paso a Paso',
      description: 'Camina 10.000 pasos en un día. ¡Estás dejando huella!',
      currentPercent: 0,
      maxPercent: 1,
    ),
    Achievements(
      title: 'Rompe Récords',
      description: 'Bate tu mejor marca personal en entrenamientos 3 veces.',
      currentPercent: 0,
      maxPercent: 3,
    ),
    Achievements(
      title: 'Nutricionista Amateur',
      description: 'Guarda 5 recetas favoritas en tu perfil.',
      currentPercent: 0,
      maxPercent: 5,
    ),
    Achievements(
      title: 'Mas duro que el Acero',
      description: 'Completa un entrenamiento de alta intensidad. ¡A sudar se ha dicho!',
      currentPercent: 0,
      maxPercent: 1,
    ),
    Achievements(
      title: 'Guardar es Ganar',
      description: 'Guarda 10 entrenamientos en tu perfil. ¡Tu biblioteca de fitness crece!',
      currentPercent: 0,
      maxPercent: 10,
    ),
  ];
  Achievements? getAchievementByTitle(String title) {
    try {
      return achievements.firstWhere((a) => a.title == title);
    } catch (e) {
      return null;
    }
  }

  void addAchievement(Achievements achievement) {
    if (!achievements.contains(achievement)) {
      achievements.add(achievement);
      notifyListeners();
      sendAchievementNotification(achievement);
    }
  }

  void updateAchievementProcess(Achievements achievement) {
    final index = achievements.indexWhere((a) =>
        a.title == achievement.title &&
        a.description == achievement.description);
    if (index != -1) {
      achievements[index] = achievement;
      notifyListeners();
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
}
