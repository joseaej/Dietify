import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/recipe.dart';
import 'package:dietify/models/repository/recipe_repository.dart';
import 'package:dietify/widgets/loading_widget.dart';
import 'package:dietify/widgets/recipe_card.dart';
import 'package:dietify/pages/recipes/recipe_detail.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late SettingsProvider settingsProvider;
  final RecipeRepository recipeRepository = RecipeRepository();
  late Future<List<Recipe>> futureRecipes;
  List<Recipe> listAllRecipes = [];
  List<Recipe> filteredRecipes = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureRecipes = recipeRepository.getAllRecipes().then((recipes) {
      listAllRecipes = recipes;
      filteredRecipes = List.from(listAllRecipes);
      return recipes;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterRecipes(String query) {
    setState(() {
      filteredRecipes = listAllRecipes.where((recipe) {
        final nameLower = recipe.title.toLowerCase();
        final difficultyLower = recipe.description?.toLowerCase() ?? '';
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower) ||
            difficultyLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recetas",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        elevation: 0,
        backgroundColor: blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Recipe>>(
                future: futureRecipes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: LoadingWidget());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (filteredRecipes.isEmpty) {
                    return const Center(
                        child: Text("No se encontraron recetas."));
                  }

                  return ListView.separated(
                    itemCount: filteredRecipes.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return RecipeCard(
                        recipe: recipe,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe),));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Buscar receta...",
        prefixIcon: Icon(Icons.search,
            color: (settingsProvider.settings!.isDarkTheme) ? font : grey600),
        hintStyle: TextStyle(
            color: (settingsProvider.settings!.isDarkTheme) ? font : grey600),
        filled: true,
        fillColor: (settingsProvider.settings!.isDarkTheme)
            ? background
            : lightBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
      onChanged: filterRecipes,
    );
  }
}
