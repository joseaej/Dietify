import 'dart:convert';
import 'package:dietify/domain/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  Future<List<Recipe>> getAllRecipes() async {
    String url = "https://foodfyapi.onrender.com/recipes";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Recipe.fromMap(json)).toList();
      } else {
        throw Exception("Error al obtener recetas: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error de conexión o formato: $e");
    }
  }
}
