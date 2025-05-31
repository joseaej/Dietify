import 'package:dietify/models/achievements.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Achievements', () {
    test('constructor', () {
      final achievement = Achievements(
        title: 'First Step',
        description: 'Complete your first workout',
        currentPercent: 50.0,
        maxPercent: 100.0,
        isAchievementCompleted: false,
      );

      expect(achievement.title, 'First Step');
      expect(achievement.description, 'Complete your first workout');
      expect(achievement.currentPercent, 50.0);
      expect(achievement.maxPercent, 100.0);
      expect(achievement.isAchievementCompleted, false);
    });

    test('fromMap', () {
      final map = {
        'title': 'Hydration Master',
        'description': 'Drink 2 liters of water',
        'currentPercent': 0.5,
        'maxPercent': 1.0,
        'isAchievementCompleted': true,
      };

      final achievement = Achievements.fromMap(map);

      expect(achievement.title, 'Hydration Master');
      expect(achievement.description, 'Drink 2 liters of water');
      expect(achievement.currentPercent, 0.5);
      expect(achievement.maxPercent, 1.0);
      expect(achievement.isAchievementCompleted, true);
    });

    test('toMap', () {
      final achievement = Achievements(
        title: 'Marathon Runner',
        description: 'Run 42 km',
        currentPercent: 0.8,
        maxPercent: 1.0,
        isAchievementCompleted: false,
      );

      final map = achievement.toMap();

      expect(map['title'], 'Marathon Runner');
      expect(map['description'], 'Run 42 km');
      expect(map['currentPercent'], 0.8);
      expect(map['maxPercent'], 1.0);
      expect(map['isAchievementCompleted'], false);
    });

    test('copyWith', () {
      final achievement = Achievements(
        title: 'First Goal',
        description: 'Reach 1000 steps',
        currentPercent: 0.3,
        maxPercent: 1.0,
        isAchievementCompleted: false,
      );

      final updated = achievement.copyWith(
        currentPercent: 0.9,
        isAchievementCompleted: true,
      );

      expect(updated.title, 'First Goal');
      expect(updated.description, 'Reach 1000 steps');
      expect(updated.currentPercent, 0.9);
      expect(updated.maxPercent, 1.0);
      expect(updated.isAchievementCompleted, true);
    });

    test('equals', () {
      final a1 = Achievements(
        title: 'A',
        description: 'Desc A',
        currentPercent: 0.1,
        maxPercent: 1.0,
        isAchievementCompleted: false,
      );

      final a2 = Achievements(
        title: 'A',
        description: 'Desc A',
        currentPercent: 0.5,
        maxPercent: 1.0,
        isAchievementCompleted: true,
      );

      final a3 = Achievements(
        title: 'B',
        description: 'Desc B',
        currentPercent: 0.1,
        maxPercent: 1.0,
        isAchievementCompleted: false,
      );

      expect(a1 == a2, isTrue);
      expect(a1 == a3, isFalse);
    });
  });
}
