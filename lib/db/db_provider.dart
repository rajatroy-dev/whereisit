import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static Database? _db;
  static Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  static initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'whereisit.db');

    var openDb = await openDatabase(path, onCreate: _onCreate);

    return openDb;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE items ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'property TEXT,'
        'room TEXT,'
        'area TEXT,'
        'name TEXT NOT NULL,'
        'serial TEXT,'
        'description TEXT,'
        'quantity INTEGER,'
        'thumbnail TEXT NOT NULL,'
        'location TEXT,'
        'favorite BOOLEAN,'
        'qr TEXT'
        ')');
  }
}
