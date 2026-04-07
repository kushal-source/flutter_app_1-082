class Recipe {
  int? id;
  String name;
  String ingredients;
  String steps;
  String category;
  String time;
  String? image;

  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.category,
    required this.time,
    this.image,
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
    };
  }

  // ADD THIS SECTION: This converts a Map from the Database back into a Recipe object
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      ingredients: map['ingredients'],
      steps: map['steps'],
      category: map['category'],
      time: map['time'],
      image: map['image'],
    );
  }
}
