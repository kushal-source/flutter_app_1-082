import 'dart:io';
import 'package:flutter/material.dart';
import 'recipe_list_screen.dart';
import 'package:image_picker/image_picker.dart';
// Make sure this is in your pubspec.yaml
import 'models/recipe.dart';
import 'database/db_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vesuvio',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/cooking.png', height: 120),
            const SizedBox(height: 28),
            const Text("Vesuvio",  style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue
            )),
            const Text("A true taste of Italy, right here at Vesuvio",  style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue
            ), textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}

// --- PRACTICAL 2: Home Screen ---
class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Recipe Book",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.menu_book,
                  color: Colors.blue,
                ),
                label: const Text(
                  "All Recipes",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  RecipeListScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                label: const Text(
                  "Add Recipe",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRecipeScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(
                  Icons.category,
                  color: Colors.blue,
                ),
                label: const Text(
                  "Categories",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PRACTICAL 3: Categories Screen ---
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"name": "Indian", "icon": Icons.rice_bowl},
      {"name": "Italian", "icon": Icons.local_pizza},
      {"name": "Chinese", "icon": Icons.ramen_dining},
      {"name": "Mexican", "icon": Icons.local_dining},
      {"name": "Desserts", "icon": Icons.cake},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    categories[index]["icon"],
                    size: 50,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    categories[index]["name"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- PRACTICAL 4: Add Recipe Screen ---
class AddRecipeScreen extends StatefulWidget{
  final Recipe? recipe;

  const AddRecipeScreen({super.key, this.recipe});

  @override
  State<AddRecipeScreen> createState() => AddRecipeScreenState();
}

class AddRecipeScreenState extends State<AddRecipeScreen>{


  @override
  void initState() {
    super.initState();

    // 3. If a recipe was passed in, fill the text fields with its data
    if (widget.recipe != null) {
      nametxt.text = widget.recipe!.name;
      ingredents.text = widget.recipe!.ingredients;
      steps.text = widget.recipe!.steps;
      selectedCategory = widget.recipe!.category;
      timecontroller.text = widget.recipe!.time;
      if (widget.recipe!.image != null) {
        _selectedImage = File(widget.recipe!.image!);
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nametxt = TextEditingController();
  final TextEditingController ingredents = TextEditingController();
  final TextEditingController steps = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();

  String? selectedCategory;
  File? _selectedImage;
  late final List<String> categories = [
    "Indian",
    "Italian",
    "Chinese",
    "Mexican",
    "Desserts"
  ];

  Future<void> pickImage() async{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Inside AddRecipeScreenState
  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select category")),
        );
        return;
      }

      // Create the Recipe object
      final recipe = Recipe(
        id: widget.recipe?.id, // This is crucial for Updating
        name: nametxt.text,
        ingredients: ingredents.text,
        steps: steps.text,
        category: selectedCategory!,
        time: timecontroller.text,
        image: _selectedImage?.path,
      );
      if (widget.recipe == null) {
        // Task: Save New
        await DBHelper.instance.insertRecipe(recipe);
      } else {
        // Task: Edit Existing
        await DBHelper.instance.updateRecipe(recipe);
      }

      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Recipe Saved to Database!", style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue,
          ),
        );

        Navigator.pop(context, true);
      }
    }
  }

  // Helper method for styling text fields
  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blue),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Recipes", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nametxt,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Recipe Name"),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter recipe name" : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: ingredents,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Recipe Ingredients"),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter ingredients" : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: steps,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Steps"),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter steps" : null,
              ),
              const SizedBox(height: 19),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                dropdownColor: Colors.white, // Dark background for dropdown menu
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Select Category"),
                items: categories
                    .map(
                      (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ),
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) =>
                value == null ? "Please select category" : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: timecontroller,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Required Time (e.g., 30 mins)"),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter required time" : null,
              ),
              const SizedBox(height: 19),

              // Image Upload
              ElevatedButton.icon(
                icon: const Icon(Icons.image, color: Colors.blue),
                label: const Text("Upload Image (Optional)", style: TextStyle(color: Colors.blue)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.blue),
                ),
                onPressed: pickImage,
              ),

              const SizedBox(height: 15),

              if (_selectedImage != null)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Image.file(
                    _selectedImage!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 25),

              // Submit Button
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Save Recipe",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- UPDATED ALL RECIPES SCREEN ---
class AllRecipeScreen extends StatelessWidget {
  AllRecipeScreen({super.key});

  // Updated list with dynamic ingredients and steps for all recipes
  final List<Map<String, dynamic>> recipes = [
    {
      "title": "Veg Biryani",
      "category": "Indian",
      "time": "45 mins",
      "ingredients": [
        "2 cups Basmati Rice",
        "1 cup Mixed Vegetables",
        "2 Onions",
        "2 Tomatoes",
        "Biryani Masala",
        "Salt",
        "Oil"
      ],
      "steps": [
        "Wash and soak the rice for 20 minutes.",
        "Heat oil in a pan and fry sliced onions.",
        "Add tomatoes and cook until soft.",
        "Add vegetables and spices.",
        "Add soaked rice and water.",
        "Cook for 20 minutes until rice is done."
      ]
    },
    {
      "title": "Pasta Alfredo",
      "category": "Italian",
      "time": "30 mins",
      "ingredients": [
        "250g Fettuccine Pasta",
        "1/2 cup Heavy Cream",
        "1/4 cup Parmesan Cheese",
        "2 cloves Garlic, minced",
        "2 tbsp Butter",
        "Salt and Black Pepper"
      ],
      "steps": [
        "Boil pasta according to package instructions.",
        "Melt butter in a pan over medium heat.",
        "Sauté garlic for 1 minute until fragrant.",
        "Stir in heavy cream and simmer for 2 minutes.",
        "Add parmesan cheese and whisk until smooth.",
        "Toss cooked pasta in the sauce and serve hot."
      ]
    },
    {
      "title": "Paneer Butter Masala",
      "category": "Indian",
      "time": "40 mins",
      "ingredients": [
        "250g Paneer (cubed)",
        "3 Tomatoes (pureed)",
        "1 Onion (finely chopped)",
        "2 tbsp Butter",
        "1/4 cup Cashew paste",
        "Garam Masala",
        "Fresh Cream"
      ],
      "steps": [
        "Heat butter in a pan and sauté onions until golden.",
        "Add tomato puree and cook until oil separates.",
        "Add cashew paste, garam masala, and salt.",
        "Simmer for 5 minutes, then add a splash of water.",
        "Add paneer cubes and cook for 3-4 minutes.",
        "Garnish with fresh cream and serve."
      ]
    },
    {
      "title": "Veg Noodles",
      "category": "Chinese",
      "time": "25 mins",
      "ingredients": [
        "1 packet Hakka Noodles",
        "1 cup Mixed Veggies (Cabbage, Carrot, Bell Peppers)",
        "2 tbsp Soy Sauce",
        "1 tbsp Vinegar",
        "1 tbsp Chili Sauce",
        "2 tbsp Oil",
        "Salt to taste"
      ],
      "steps": [
        "Boil noodles al dente and toss with a few drops of oil.",
        "Heat oil in a wok on high heat.",
        "Stir fry all the vegetables for 2-3 minutes.",
        "Add soy sauce, vinegar, chili sauce, and salt.",
        "Add boiled noodles and toss well to coat.",
        "Serve hot."
      ]
    },
    {
      "title": "Chocolate Cake",
      "category": "Dessert",
      "time": "60 mins",
      "ingredients": [
        "1.5 cups All-purpose Flour",
        "1 cup Sugar",
        "1/3 cup Cocoa Powder",
        "1 tsp Baking Soda",
        "1/2 cup Oil",
        "1 cup Water or Milk",
        "1 tsp Vanilla Extract"
      ],
      "steps": [
        "Preheat oven to 180°C (350°F).",
        "Mix dry ingredients (flour, sugar, cocoa, baking soda) in a bowl.",
        "Add oil, water/milk, and vanilla extract.",
        "Whisk until the batter is smooth and lump-free.",
        "Pour into a greased baking pan.",
        "Bake for 30-35 minutes. Let cool before slicing."
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe List", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index]; // Grab the current recipe

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.restaurant_menu, color: Colors.blue),
              title: Text(recipe["title"] as String),
              subtitle: Text(
                  "Category: ${recipe["category"]}\nCooking Time: ${recipe["time"]}"),
              onTap: () {
                // Pass the specific data to the detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailPage(
                      title: recipe["title"] as String,
                      ingredients: List<String>.from(recipe["ingredients"]),
                      steps: List<String>.from(recipe["steps"]),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- UPDATED RECIPE DETAIL PAGE ---
class RecipeDetailPage extends StatelessWidget {
  // Define variables that will receive data from the constructor
  final String title;
  final List<String> ingredients;
  final List<String> steps;

  // Constructor requires the data to be passed in
  const RecipeDetailPage({
    super.key,
    required this.title,
    required this.ingredients,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ingredients",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Use the dynamic 'ingredients' list
              ...ingredients.map((item) {
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.blue),
                  title: Text(item),
                );
              }).toList(),

              const SizedBox(height: 20),

              const Text(
                "Preparation Steps",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Use the dynamic 'steps' list
              ...steps.asMap().entries.map((entry) {
                int index = entry.key + 1;
                String step = entry.value;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("$index", style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(step),
                );
              }).toList(),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Edit button clicked")),
                      );
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Recipe Deleted")),
                      );
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Practical-8 Create a recipe card widget displaying image, recipe title, and category, and reuse it
// across the app.

class RecipeCard extends StatelessWidget {
  final String title;
  final String category;
  final String image;
  final VoidCallback? onTap; // Optional: tap action
  const RecipeCard({
    required this.title,
    required this.category,
    required this.image,
    this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
// TITLE
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5),
// CATEGORY
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}