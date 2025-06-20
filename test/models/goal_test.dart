import 'package:dietify/domain/models/goal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Goal', () {
    test('Default constructor', () {
      final goal = Goal();

      expect(goal.currentWaterIntake, 0);
      expect(goal.currentCalories, 0);
      expect(goal.fat, 0);
      expect(goal.carbs, 0);
      expect(goal.protein, 0);
      expect(goal.totalCalories, null);
      expect(goal.maxWaterIntake, null);
      expect(goal.maxFats, null);
      expect(goal.maxCarbs, null);
      expect(goal.maxProtein, null);
      expect(goal.date, null);
    });

    test('clearGoals', () {
      final goal = Goal.clearGoal();

      expect(goal.currentWaterIntake, 0);
      expect(goal.currentCalories, 0);
      expect(goal.fat, 0);
      expect(goal.carbs, 0);
      expect(goal.protein, 0);
      expect(goal.totalCalories, 0);
      expect(goal.maxWaterIntake, 0);
      expect(goal.maxFats, 0);
      expect(goal.maxCarbs, 0);
      expect(goal.maxProtein, 0);
      expect(goal.date, isNotNull);
    });

    test('getMaxWaterIntake', () {
      final goal = Goal();
      final maxWater = goal.getMaxWaterIntake(70);
      expect(maxWater, 70 * 35);
      expect(goal.maxWaterIntake, maxWater);
    });

    test('getTotalCalories', () {
      final goal = Goal();

      final maleCalories = goal.getTotalCalories('male', 70, 175, 30);
      expect(maleCalories, closeTo(66 + 13.7 * 70 + 5 * 175 - 6.8 * 30, 0.1));
      expect(goal.totalCalories, maleCalories);

      final femaleCalories = goal.getTotalCalories('female', 60, 160, 25);
      expect(femaleCalories, closeTo(655 + 9.6 * 60 + 1.8 * 160 - 4.7 * 25, 0.1));
      expect(goal.totalCalories, femaleCalories);
    });

    test('getTotalCalories', () {
      final goal = Goal();
      expect(goal.getTotalCalories('male', 0, 170, 25), null);
      expect(goal.getTotalCalories('female', 60, 0, 25), null);
      expect(goal.getTotalCalories('female', 60, 160, 0), null);
    });

    test('getMaxFats y getMaxCarbs', () {
      final goal = Goal();
      expect(goal.getMaxFats(), null);
      expect(goal.getMaxCarbs(), null);

      goal.totalCalories = 2000;
      expect(goal.getMaxFats(), closeTo((2000 * 0.25) / 9, 0.001));
      expect(goal.maxFats, closeTo((2000 * 0.25) / 9, 0.001));

      expect(goal.getMaxCarbs(), closeTo((2000 * 0.55) / 4, 0.001));
      expect(goal.maxCarbs, closeTo((2000 * 0.55) / 4, 0.001));
    });

    test('getMaxProtein ', () {
      final goal = Goal();
      final maxProtein = goal.getMaxProtein(70);
      expect(maxProtein, 70 * 0.8);
      expect(goal.maxProtein, maxProtein);
    });

    test('fromMap', () {
      final dateString = DateTime.now().toIso8601String();
      final map = {
        'waterIntake': 2450.0,
        'currentWaterIntake': 1200.0,
        'totalCalories': 2200.0,
        'currentCalories': 1500.0,
        'fat': 70.0,
        'carbs': 250.0,
        'protein': 150.0,
        'date': dateString,
      };

      final goal = Goal.fromMap(map);

      expect(goal.maxWaterIntake, 2450);
      expect(goal.currentWaterIntake, 1200);
      expect(goal.totalCalories, 2200);
      expect(goal.currentCalories, 1500);
      expect(goal.fat, 70);
      expect(goal.carbs, 250);
      expect(goal.protein, 150);
      expect(goal.date?.toIso8601String(), dateString);
    });

    test('toMap', () {
      final now = DateTime.now();
      final goal = Goal(
        maxWaterIntake: 3000,
        currentWaterIntake: 1500,
        totalCalories: 2100,
        currentCalories: 1000,
        fat: 60,
        carbs: 200,
        protein: 100,
        date: now,
      );

      final map = goal.toMap();

      expect(map['waterIntake'], 3000);
      expect(map['currentWaterIntake'], 1500);
      expect(map['totalCalories'], 2100);
      expect(map['currentCalories'], 1000);
      expect(map['fat'], 60);
      expect(map['carbs'], 200);
      expect(map['protein'], 100);
      expect(map['date'], now.toIso8601String());
    });

    test('copyWith', () {
      final goal = Goal(
        maxWaterIntake: 2000,
        currentWaterIntake: 1000,
        totalCalories: 1800,
        currentCalories: 900,
        fat: 50,
        carbs: 180,
        protein: 80,
        maxFats: 60,
        maxCarbs: 200,
        maxProtein: 90,
        date: DateTime(2025, 1, 1),
      );

      final copy = goal.copyWith(
        maxWaterIntake: 2500,
        fat: 55,
        date: DateTime(2025, 5, 5),
      );

      expect(copy.maxWaterIntake, 2500);
      expect(copy.fat, 55);
      expect(copy.date, DateTime(2025, 5, 5));
      expect(copy.currentWaterIntake, 1000);
      expect(copy.totalCalories, 1800);
      expect(copy.maxCarbs, 200);
    });
  });
}
