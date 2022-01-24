import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider _dbProvider = DBProvider._();

  static get instance => _dbProvider;

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await _initDb();
    return _db;
  }

  static _initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'whereisit.db');

    var openDb = await openDatabase(path, onCreate: _onCreate);

    return openDb;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE properties ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL'
        ')');

    await db.execute('CREATE TABLE rooms ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL'
        ')');

    await db.execute('CREATE TABLE areas ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL'
        ')');

    await db.execute('CREATE TABLE items ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'property_id INTEGER NOT NULL,'
        'room_id INTEGER NOT NULL,'
        'area_id INTEGER NOT NULL,'
        'name TEXT NOT NULL,'
        'thumbnail TEXT NOT NULL,'
        'quantity INTEGER DEFAULT 1 NOT NULL,'
        'favorite INTEGER DEFAULT 0 NOT NULL CHECK (favorite IN (0, 1)),'
        'serial TEXT,'
        'description TEXT,'
        'location TEXT,'
        'address TEXT'
        'qr TEXT,'
        'createdAt INTEGER NOT NULL,'
        'updatedAt INTEGER NOT NULL,'
        'FOREIGN KEY (property_id) REFERENCES properties (id) INTEGER ON DELETE RESTRICT,'
        'FOREIGN KEY (room_id) REFERENCES rooms (id) INTEGER ON DELETE RESTRICT,'
        'FOREIGN KEY (area_id) REFERENCES areas (id) INTEGER ON DELETE RESTRICT'
        ')');

    await db.execute('CREATE TABLE images ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'filename TEXT NOT NULL,'
        'filelocation TEXT NOT NULL'
        ')');

    await db.execute('CREATE TABLE tags ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL'
        ')');

    await db.execute('CREATE TABLE items_images ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'item_id INTEGER NOT NULL,'
        'image_id INTEGER,'
        'FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE,'
        'FOREIGN KEY (image_id) REFERENCES images (id) ON DELETE SET NULL'
        ')');

    await db.execute('CREATE TABLE items_tags ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'item_id INTEGER,'
        'tag_id INTEGER NOT NULL,'
        'FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE SET NULL,'
        'FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE'
        ')');
  }
}
