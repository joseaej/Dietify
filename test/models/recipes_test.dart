import 'package:dietify/models/recipe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Recipe', () {
    final sampleMap = {
      'id': 'r1',
      'title': 'Paella',
      'description': 'Delicious Spanish rice dish',
      'ingredients': ['rice', 'saffron', 'chicken'],
      'steps': ['Step 1', 'Step 2', 'Step 3'],
      'preparation_time': 15,
      'cooking_time': 45,
      'servings': 4,
      'category': 'Main Course',
      'fat': 12.5,
      'carbs': 60.0,
      'protein': 30.0,
      'calories': 500.0,
      'image_url': 'https://example.com/paella.jpg',
      'video_url': 'https://youtube.com/paella',
      'created_at': '2025-05-28T10:00:00.000Z',
      'updated_at': '2025-05-29T12:30:00.000Z',
    };

    test('fromMap', () {
      final recipe = Recipe.fromMap(sampleMap);

      expect(recipe.id, 'r1');
      expect(recipe.title, 'Paella');
      expect(recipe.description, 'Delicious Spanish rice dish');
      expect(recipe.ingredients, ['rice', 'saffron', 'chicken']);
      expect(recipe.steps.length, 3);
      expect(recipe.preparationTime, 15);
      expect(recipe.cookingTime, 45);
      expect(recipe.servings, 4);
      expect(recipe.category, 'Main Course');
      expect(recipe.fat, 12.5);
      expect(recipe.carbs, 60.0);
      expect(recipe.protein, 30.0);
      expect(recipe.calories, 500.0);
      expect(recipe.imageUrl, 'https://example.com/paella.jpg');
      expect(recipe.videoUrl, 'https://youtube.com/paella');

      expect(recipe.createdAt, DateTime.parse('2025-05-28T10:00:00.000Z'));
      expect(recipe.updatedAt, DateTime.parse('2025-05-29T12:30:00.000Z'));
    });

    test('toMap', () {
      final recipe = Recipe.fromMap(sampleMap);
      final map = recipe.toMap();

      expect(map['id'], 'r1');
      expect(map['title'], 'Paella');
      expect(map['description'], 'Delicious Spanish rice dish');
      expect(map['ingredients'], ['rice', 'saffron', 'chicken']);
      expect(map['steps'], ['Step 1', 'Step 2', 'Step 3']);
      expect(map['preparation_time'], 15);
      expect(map['cooking_time'], 45);
      expect(map['servings'], 4);
      expect(map['category'], 'Main Course');
      expect(map['fat'], 12.5);
      expect(map['carbs'], 60.0);
      expect(map['protein'], 30.0);
      expect(map['calories'], 500.0);
      expect(map['image_url'], 'https://example.com/paella.jpg');
      expect(map['video_url'], 'https://youtube.com/paella');
      expect(map['created_at'], '2025-05-28T10:00:00.000Z');
      expect(map['updated_at'], '2025-05-29T12:30:00.000Z');
    });
  });
}
