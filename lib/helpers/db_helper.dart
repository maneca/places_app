import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper{
  static Future<sql.Database> _openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'great_places.db'), onCreate: (db, version){
      return db.execute('CREATE TABLE places(id TEXT PRIMARY KEY, name TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insertPlace(Map<String, Object> data) async{
    final db = await _openDatabase();
    await db.insert("places", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getPlaces() async{
    final db = await _openDatabase();
    return await db.rawQuery("SELECT * FROM places");
  }
}