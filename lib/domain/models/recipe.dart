class Recipe {
  final String id;
  final String title;
  final String? description;
  final List<String> ingredients;
  final List<String> steps;
  final int? preparationTime;
  final int? cookingTime;
  final int? servings;
  final String? category;
  final double? fat;
  final double? carbs;
  final double? protein;
  final double? calories;
  final String? imageUrl;
  final String? videoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Recipe({
    required this.id,
    required this.title,
    this.description,
    required this.ingredients,
    required this.steps,
    this.preparationTime,
    this.cookingTime,
    this.servings,
    this.category,
    this.fat,
    this.carbs,
    this.protein,
    this.calories,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'],
      ingredients: List<String>.from(map['ingredients']),
      steps: List<String>.from(map['steps']),
      preparationTime: map['preparation_time'],
      cookingTime: map['cooking_time'],
      servings: map['servings'],
      category: map['category'],
      fat: map['fat']?.toDouble(),
      carbs: map['carbs']?.toDouble(),
      protein: map['protein']?.toDouble(),
      calories: map['calories']?.toDouble(),
      imageUrl: map['image_url'],
      videoUrl: map['video_url'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'steps': steps,
      'preparation_time': preparationTime,
      'cooking_time': cookingTime,
      'servings': servings,
      'category': category,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
      'calories': calories,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
