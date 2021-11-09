import 'package:food_store_app/data/model/restaurant_table.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const _TBL_BOOKMARK = "bookmark";

  Logger _logger = Logger();

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = "$path/foodstore.db";

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_TBL_BOOKMARK (
        id TEXT NOT NULL UNIQUE,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating TEXT
      );
    ''');
  }

  Future<int> insertBookmark(RestaurantTable restaurant) async {
    _logger.d(restaurant.toJson());
    _logger.d("INSERT BOOKMARK");
    final db = await database;
    return await db!.insert(_TBL_BOOKMARK, restaurant.toJson());
  }

  Future<int> removeRestaurant(RestaurantTable restaurant) async {
    _logger.d(restaurant.toJson());
    _logger.d("REMOVE BOOKMARK");
    final db = await database;
    return await db!.delete(
      _TBL_BOOKMARK,
      where: "id = ?",
      whereArgs: [restaurant.id],
    );
  }

  Future<Map<String, dynamic>?> getRestaurantById(String id) async {
    _logger.d(id);
    _logger.d("GET RESTAURANT BY ID");
    final db = await database;
    final result = await db!.query(
      _TBL_BOOKMARK,
      where: "id = ?",
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }
}
