class Recipe {
  int? id;
  String name;
  String ingredients;
  String steps;
  String category;
  String time;
  String? image;

  // 1. ADDED: The new property to track if it is a favorite
  int isFavorite;

  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.category,
    required this.time,
    this.image,
    // 2. ADDED: Set the default to 0 (Not a favorite)
    this.isFavorite = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      'category': category,
      'time': time,
      'image': image,
      // 3. ADDED: Save it to the database map
      'isFavorite': isFavorite,
    };
  }

  // Converts a Map from the Database back into a Recipe object
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      ingredients: map['ingredients'],
      steps: map['steps'],
      category: map['category'],
      time: map['time'],
      image: map['image'],
      // 4. ADDED: Read it from the database map.
      // The "?? 0" is a safety check just in case the database returns null!
      isFavorite: map['isFavorite'] ?? 0,
    );
  }
}