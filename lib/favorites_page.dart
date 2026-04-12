import 'package:flutter/material.dart';
// THIS IS THE LINE THAT FIXES YOUR ERROR! It tells this file what a "Recipe" is.
import 'models/recipe.dart';

class FavoritesPage extends StatelessWidget {
  // Now it properly accepts a List of Recipe objects from your database
  final List<Recipe> favoriteRecipes;

  const FavoritesPage({super.key, required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black87, // Matching your friend's dark theme!
      body: favoriteRecipes.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet!",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return Card(
            color: Colors.grey[900], // Dark card color
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(
                recipe.name, // Using recipe.name from your database model
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              subtitle: Text(
                "${recipe.category} • ${recipe.time}",
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(Icons.favorite, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}