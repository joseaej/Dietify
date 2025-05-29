import 'package:dietify/models/workout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Workout', () {
    test('toMap and fromMap should be consistent', () {
      final workout = Workout(
        id: '1',
        name: 'Push Ups',
        duration: 30,
        type: 'Strength',
        intensity: 'High',
        notes: 'Do slowly',
        muscles: 'Chest, Triceps',
        calories: 120.5,
        urlVideo: 'https://example.com/video',
      );

      final map = workout.toMap();
      final recreated = Workout.fromMap(map);

      expect(recreated.name, workout.name);
      expect(recreated.duration, workout.duration);
      expect(recreated.type, workout.type);
      expect(recreated.intensity, workout.intensity);
      expect(recreated.muscles, workout.muscles);
      expect(recreated.calories, workout.calories);
      expect(recreated.notes, workout.notes);
      expect(recreated.urlVideo, workout.urlVideo);
    });

    test('copyWith should override selected fields', () {
      final original = Workout(
        id: '1',
        name: 'Plank',
        duration: 60,
        type: 'Core',
        intensity: 'Medium',
      );

      final modified = original.copyWith(
        duration: 90,
        intensity: 'High',
      );

      expect(modified.id, original.id);
      expect(modified.name, original.name);
      expect(modified.duration, 90);
      expect(modified.intensity, 'High');
    });

    test('equality should compare selected fields', () {
      final a = Workout(
        name: 'Run',
        duration: 20,
        type: 'Cardio',
        muscles: 'Legs',
        calories: 200,
      );

      final b = Workout(
        name: 'Run',
        duration: 20,
        type: 'Cardio',
        muscles: 'Legs',
        calories: 200,
      );

      final c = Workout(
        name: 'Jog',
        duration: 20,
        type: 'Cardio',
        muscles: 'Legs',
        calories: 200,
      );

      expect(a == b, true);
      expect(a == c, false);
    });
  });
}
