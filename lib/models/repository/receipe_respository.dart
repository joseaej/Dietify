import 'package:dietify/models/recipes.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReceipeRespository {
  Future<List<Recipe>> fetchRecipes() async {
    final response = await Dio().get(
        'https://api.spoonacular.com/recipes/random?number=10&apiKey=${dotenv.env["API_KEY"]!}');

    if (response.statusCode == 200) {
      List recipesJson = response.data['recipes'];
      return recipesJson.map((r) => Recipe.fromJson(r)).toList();
    } else {
      throw Exception('Error al cargar recetas');
    }
  }
}
