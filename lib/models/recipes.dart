import 'ingredient.dart';

class Recipe {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final double healthScore;
  final double pricePerServing;
  final List<Ingredient> ingredients;
  final String summary;
  final List<String> cuisines;
  final List<String> dishTypes;
  final List<String> diets;
  final List<String> occasions;
  final List<InstructionStep> instructions;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.healthScore,
    required this.pricePerServing,
    required this.ingredients,
    required this.summary,
    required this.cuisines,
    required this.dishTypes,
    required this.diets,
    required this.occasions,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      sourceUrl: json['sourceUrl'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      glutenFree: json['glutenFree'],
      dairyFree: json['dairyFree'],
      healthScore: (json['healthScore'] ?? 0).toDouble(),
      pricePerServing: (json['pricePerServing'] ?? 0).toDouble(),
      ingredients: (json['extendedIngredients'] as List)
          .map((i) => Ingredient.fromJson(i))
          .toList(),
      summary: json['summary'],
      cuisines: List<String>.from(json['cuisines'] ?? []),
      dishTypes: List<String>.from(json['dishTypes'] ?? []),
      diets: List<String>.from(json['diets'] ?? []),
      occasions: List<String>.from(json['occasions'] ?? []),
      instructions: (json['analyzedInstructions'] as List)
          .expand((instr) => (instr['steps'] as List?) ?? [])
          .map((step) => InstructionStep.fromJson(step))
          .toList(),
    );
  }
}