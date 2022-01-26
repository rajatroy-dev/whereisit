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

    var openDb = await openDatabase(
      path,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );

    return openDb;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE locations ('
        'id INTEGER PRIMARY KEY, '
        'location TEXT, '
        'address TEXT NOT NULL UNIQUE'
        ')');

    await db.execute('CREATE TABLE properties ('
        'id INTEGER PRIMARY KEY, '
        'location_id INTEGER, '
        'name TEXT NOT NULL UNIQUE, '
        'FOREIGN KEY (location_id) REFERENCES locations (id) ON DELETE RESTRICT'
        ')');

    await db.execute('CREATE TABLE rooms ('
        'id INTEGER PRIMARY KEY, '
        'name TEXT NOT NULL UNIQUE'
        ')');

    await db.execute('CREATE TABLE categories ('
        'id INTEGER PRIMARY KEY, '
        'name TEXT NOT NULL UNIQUE'
        ')');

    await db.execute('INSERT INTO categories '
        '(name) '
        'VALUES '
        '(\'Uncategorized\')');

    await db.execute('CREATE TABLE items ('
        'id INTEGER PRIMARY KEY, '
        'property_id INTEGER, '
        'room_id INTEGER, '
        'category_id INTEGER DEFAULT 1 NOT NULL, '
        'name TEXT NOT NULL, '
        'thumbnail TEXT NOT NULL, '
        'quantity INTEGER DEFAULT 1 NOT NULL, '
        'favorite INTEGER DEFAULT 0 NOT NULL CHECK (favorite IN (0, 1)), '
        'location_id INTEGER, '
        'serial TEXT, '
        'description TEXT, '
        'qr TEXT UNIQUE, '
        'createdAt INTEGER NOT NULL, '
        'updatedAt INTEGER NOT NULL, '
        'FOREIGN KEY (property_id) REFERENCES properties (id) ON DELETE RESTRICT, '
        'FOREIGN KEY (room_id) REFERENCES rooms (id) ON DELETE RESTRICT, '
        'FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT, '
        'FOREIGN KEY (location_id) REFERENCES locations (id) ON DELETE RESTRICT'
        ')');

    await db.execute('CREATE TABLE images ('
        'id INTEGER PRIMARY KEY, '
        'item_id INTEGER NOT NULL, '
        'filename TEXT NOT NULL UNIQUE, '
        'filelocation TEXT NOT NULL UNIQUE, '
        'FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE'
        ')');

    await db.execute('CREATE TABLE tags ('
        'id INTEGER PRIMARY KEY, '
        'name TEXT NOT NULL UNIQUE'
        ')');

    await db.execute('CREATE TABLE items_tags ('
        'id INTEGER PRIMARY KEY, '
        'item_id INTEGER, '
        'tag_id INTEGER NOT NULL, '
        'FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE SET NULL, '
        'FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE'
        ')');
  }
}
