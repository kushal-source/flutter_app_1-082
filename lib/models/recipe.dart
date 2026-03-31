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
}