import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'food_app.db'),
      onCreate: (db, version) async {
        // Create tables
        await db.execute('CREATE TABLE favorites(id TEXT, userId TEXT, title TEXT, price REAL, imageUrl TEXT, PRIMARY KEY (id, userId))');
        await db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, email TEXT, phone TEXT, address TEXT)');
        await db.execute('CREATE TABLE orders(id TEXT PRIMARY KEY, userId TEXT, date TEXT, total REAL, status TEXT)');
        await db.execute('CREATE TABLE order_items(id INTEGER PRIMARY KEY AUTOINCREMENT, orderId TEXT, title TEXT, price REAL, quantity INTEGER)');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          // Upgrade favorites table to include userId
          try {
            await db.execute('ALTER TABLE favorites ADD COLUMN userId TEXT');
          } catch (e) {
            // Might already exist
          }
        }
      },
      version: 5, 
    );
  }

  static Future<void> insert(String table, Map<String, Object?> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table, {String? where, List<Object?>? whereArgs}) async {
    final db = await DBHelper.database();
    return db.query(table, where: where, whereArgs: whereArgs);
  }

  static Future<void> delete(String table, {String? where, List<Object?>? whereArgs}) async {
    final db = await DBHelper.database();
    await db.delete(table, where: where, whereArgs: whereArgs);
  }
}
