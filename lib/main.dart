import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Make sure this is in your pubspec.yaml

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
        scaffoldBackgroundColor: Colors.black,
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
           const Text("Three generations of Buccos sweated over that stove",  style: TextStyle(
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
                      builder: (context) => const AllRecipeScreen(),
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
 const AddRecipeScreen({super.key});
 @override
 State<AddRecipeScreen> createState() => AddRecipeScreenState();
}

class AddRecipeScreenState extends State<AddRecipeScreen>{

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

  void submitForm(){
    if (_formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select category")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Recipe Added Successfully!", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
      );

      Navigator.pop(context);
  }}

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
                 style: const TextStyle(color: Colors.white),
                 decoration: _buildInputDecoration("Recipe Name"),
                 validator: (value) =>
                 value == null || value.isEmpty ? "Please enter recipe name" : null,
               ),
               const SizedBox(height: 19),
               TextFormField(
                 controller: ingredents,
                 style: const TextStyle(color: Colors.white),
                 decoration: _buildInputDecoration("Recipe Ingredients"),
                 validator: (value) =>
                 value == null || value.isEmpty ? "Please enter ingredients" : null,
               ),
               const SizedBox(height: 19),
               TextFormField(
                 controller: steps,
                 style: const TextStyle(color: Colors.white),
                 decoration: _buildInputDecoration("Steps"),
                 validator: (value) =>
                 value == null || value.isEmpty ? "Please enter steps" : null,
               ),
               const SizedBox(height: 19),

               DropdownButtonFormField<String>(
                 value: selectedCategory,
                 dropdownColor: Colors.white, // Dark background for dropdown menu
                 style: const TextStyle(color: Colors.white),
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
                 style: const TextStyle(color: Colors.white),
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
                   style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                 ),
               ),
             ],
           ),
       ),
     ),
   );
  }
}

// --- PLACEHOLDER ---
class AllRecipeScreen extends StatelessWidget {
  const AllRecipeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('All Recipes'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      ),
      body: const Center(child: Text('All Recipes Screen (Pending)', style: TextStyle(color: Colors.blue))),
    );
  }
}