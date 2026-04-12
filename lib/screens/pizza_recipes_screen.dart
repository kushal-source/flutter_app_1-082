import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChickenRecipesScreen extends StatefulWidget {
  const ChickenRecipesScreen({super.key});

  @override
  _ChickenRecipesScreenState createState() => _ChickenRecipesScreenState();
}

class _ChickenRecipesScreenState extends State<ChickenRecipesScreen> {
  // Good practice: explicitly state that this is a list of dynamic items
  List<dynamic> meals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChickenRecipes();
  }

  // Fetch Data from TheMealDB API
  Future<void> fetchChickenRecipes() async {
    const url = "https://www.themealdb.com/api/json/v1/1/search.php?s=chicken";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          // TheMealDB returns null for "meals" if it finds nothing.
          // The ?? [] ensures we assign an empty list instead of crashing.
          meals = data["meals"] ?? [];
          isLoading = false;
        });
      }
    } catch (e) {
      // If there is no internet, we catch the error here so the app doesn't crash
      setState(() {
        isLoading = false;
      });
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trending Chicken", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.deepOrange))
          : meals.isEmpty
          ? const Center(child: Text("No recipes found."))
          : ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  meal["strMealThumb"],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  // Fallback icon if the image URL is broken
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 60),
                ),
              ),
              title: Text(
                meal["strMeal"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(meal["strCategory"] ?? "Chicken"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}