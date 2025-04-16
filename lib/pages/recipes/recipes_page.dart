import 'package:dietify/models/repository/receipe_respository.dart';
import 'package:flutter/material.dart';

import 'recipe_card.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    //ReceipeRespository respository = ReceipeRespository();
    return Scaffold(
      body: Column(
        children: [
          RecipeCard(),
        ],
      )
    );
  }
}

/*
FutureBuilder(
        future: respository.fetchRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
                child: Text("No se encontraron entrenamientos."));
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final recipe = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    Text(recipe.title),
                    Image.network(recipe.image),
                    Text(recipe.ingredients.first.name),
                  ],
                )
              );
            },
          );
        },
      ),




*/ 
import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}