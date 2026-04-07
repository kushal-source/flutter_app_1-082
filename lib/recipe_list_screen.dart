import 'dart:io';
import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'models/recipe.dart';
import 'main.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  RecipeListScreenState createState() => RecipeListScreenState();
}

class RecipeListScreenState extends State<RecipeListScreen> {
  // 1. We need TWO lists now. One for all data, one for the filtered data.
  List<Recipe> allRecipes = [];
  List<Recipe> filteredRecipes = [];

  // 2. Controller to listen to what the user types in the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshRecipes();

    // 3. Add a listener to the search bar so it filters every time a letter is typed
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    // Always clean up controllers when the screen is closed!
    _searchController.dispose();
    super.dispose();
  }

  // 4. The method that does the actual filtering
  void _filterRecipes() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredRecipes = allRecipes.where((recipe) {
        // Search by recipe name OR category
        return recipe.name.toLowerCase().contains(query) ||
            recipe.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  void refreshRecipes() async {
    final data = await DBHelper.instance.getAllRecipes();
    setState(() {
      allRecipes = data;
      _filterRecipes(); // Apply the search filter immediately after loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recipes", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column( // 5. Use a Column to hold both the SearchBar and the ListView
        children: [
          // --- SEARCH BAR WIDGET ---
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search recipes...",
                hintText: "Type a name or category (e.g., Pizza, Italian)",
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.5),
                ),
              ),
            ),
          ),

          // --- RECIPE LIST ---
          // 6. Wrap ListView in Expanded so it takes up the remaining screen space
          Expanded(
            child: filteredRecipes.isEmpty
                ? const Center(
                child: Text(
                    "No recipes found.",
                    style: TextStyle(fontSize: 16, color: Colors.grey)
                )
            )
                : ListView.builder(
              itemCount: filteredRecipes.length, // Use the filtered list!
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: recipe.image != null && recipe.image!.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                          File(recipe.image!),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover
                      ),
                    )
                        : const Icon(Icons.fastfood, size: 40, color: Colors.blue),
                    title: Text(
                        recipe.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    subtitle: Text("${recipe.category} • ${recipe.time}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddRecipeScreen(recipe: recipe),
                              ),
                            );
                            refreshRecipes();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            await DBHelper.instance.deleteRecipe(recipe.id!);
                            refreshRecipes();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}