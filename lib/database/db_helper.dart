import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/recipe.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  // We want version 2 to trigger the upgrade
  static const int _version = 2;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // --- THE FIX IS HERE ---
    // Changed "version: 1" to "version: _version"
    // Added "onUpgrade: _onUpgrade"
    return await openDatabase(
      path,
      version: _version,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      ingredients TEXT NOT NULL,
      steps TEXT NOT NULL,
      category TEXT NOT NULL,
      time TEXT NOT NULL,
      image TEXT,
      isFavorite INTEGER DEFAULT 0 
    )
    ''');
  }

  // This will finally run because we attached it to openDatabase!
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE recipes ADD COLUMN isFavorite INTEGER DEFAULT 0');
    }
  }

  Future<int> insertRecipe(Recipe recipe) async {
    final db = await instance.database;
    return await db.insert('recipes', recipe.toMap());
  }

  Future<List<Recipe>> getAllRecipes() async {
    final db = await instance.database;
    final result = await db.query('recipes');
    return result.map((json) => Recipe.fromMap(json)).toList();
  }

  Future<int> updateRecipe(Recipe recipe) async {
    final db = await instance.database;
    return await db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<int> deleteRecipe(int id) async {
    final db = await instance.database;
    return await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> toggleFavorite(int id, int currentStatus) async {
    final db = await database;
    int newStatus = currentStatus == 1 ? 0 : 1;
    await db.rawUpdate('UPDATE recipes SET isFavorite = ? WHERE id = ?', [newStatus, id]);
  }
}