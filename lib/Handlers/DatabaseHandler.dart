import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Screens/User.dart';

class DatabaseHandler {
  static const int _version = 2;
  static const String _dbName = "Users.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async =>
          await db.execute("CREATE TABLE Users(name TEXT, email TEXT PRIMARY KEY, hashedPW TEXT)"),
      version: _version,
    );
  }

  static Future<int> addUser(User user) async {
    final db = await _getDB();
    return await db.insert('Users', user.toJson(), conflictAlgorithm: ConflictAlgorithm.abort);
  }

  static Future<int> updateUser(User user) async {
    final db = await _getDB();
    return await db.update('Users', user.toJson(),
        where: 'email = ?', whereArgs: [user.getEmail()], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<User?> getUser(String email) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('Users', where: 'email = ?', whereArgs: [email]);

      if(maps.isEmpty){
        return User(name: "", email: "", hashedPW: "");
      }else {
        return User.fromJson(maps.first);
      }
  }

  static Future<List<User>?> getAllUsers() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('Users');
    if (maps.isEmpty) return null;
    return List.generate(maps.length, (i) => User.fromJson(maps[i]));
  }
}
