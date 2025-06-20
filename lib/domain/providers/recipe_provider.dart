import 'package:dietify/domain/models/recipe.dart';
import 'package:dietify/domain/repository/recipe_repository.dart';
import 'package:flutter/material.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeRepository recipeRepository = RecipeRepository();
  Future<List<Recipe>>? futureRecipes;
  Future<void> getAllRecipes()async {
    futureRecipes = recipeRepository.getAllRecipes();
  }
}