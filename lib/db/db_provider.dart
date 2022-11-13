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
    // users
    db.execute('CREATE TABLE users ('
        'id INTEGER PRIMARY KEY, '
        'name TEXT NOT NULL, '
        'username TEXT NOT NULL UNIQUE, '
        'created_by TEXT NOT NULL, '
        'created_at TEXT NOT NULL, '
        'updated_by TEXT NOT NULL, '
        'updated_at TEXT NOT NULL'
        ');');

    // location is like a geographical location
    // It will have an address
    // It can also have co-ordinates
    await db.execute('CREATE TABLE locations ('
        'id INTEGER PRIMARY KEY, '
        'latitude TEXT, '
        'longitude TEXT, '
        'address TEXT NOT NULL UNIQUE, '
        'created_by TEXT NOT NULL, '
        'created_at TEXT NOT NULL, '
        'updated_by TEXT NOT NULL, '
        'updated_at TEXT NOT NULL'
        ');');

    // A house property could be your home, an office, a shop, a building or
    // some land attached to the building like a parking lot.
    await db.execute('CREATE TABLE properties ('
        'id INTEGER PRIMARY KEY, '
        'location_id INTEGER REFERENCES locations(id) ON DELETE RESTRICT, '
        'name TEXT NOT NULL UNIQUE, '
        'created_by TEXT NOT NULL, '
        'created_at TEXT NOT NULL, '
        'updated_by TEXT NOT NULL, '
        'updated_at TEXT NOT NULL'
        ');');

    // Room exists in a property
    await db.execute('CREATE TABLE rooms ('
        'id INTEGER PRIMARY KEY, '
        'name TEXT NOT NULL, '
        'created_by TEXT NOT NULL, '
        'created_at TEXT NOT NULL, '
        'updated_by TEXT NOT NULL, '
        'updated_at TEXT NOT NULL'
        ');');

    // The items stored will normally be categorized like books, electronics ...
    await db.execute('CREATE TABLE categories ('
        'id INTEGER PRIMARY KEY, '
        'name TEXT NOT NULL UNIQUE, '
        'created_by TEXT NOT NULL, '
        'created_at TEXT NOT NULL, '
        'updated_by TEXT NOT NULL, '
        'updated_at TEXT NOT NULL'
        ');');

    DateTime now = DateTime.now();
    String isoDate = now.toIso8601String();
    await db.execute('INSERT INTO categories '
        '(name, '
        'created_by, '
        'created_at, '
        'updated_by, '
        'updated_at) '
        'VALUES '
        '(\'Uncategorized\', '
        'system, '
        '$isoDate, '
        'system, '
        '$isoDate);');

    // Items are the things that are stored
    await db.execute('CREATE TABLE items ('
        'id INTEGER PRIMARY KEY, '
        'location_id INTEGER REFERENCES locations(id) ON DELETE RESTRICT, '
        'property_id INTEGER REFERENCES properties(id) ON DELETE RESTRICT, '
        'room_id INTEGER REFERENCES rooms(id) ON DELETE RESTRICT, '
        'category_id INTEGER DEFAULT 1 NOT NULL REFERENCES categories(id) ON DELETE RESTRICT, '
        'name TEXT NOT NULL, '
        'thumbnail TEXT NOT NULL, '
        'quantity INTEGER DEFAULT 1 NOT NULL, '
        'favorite INTEGER DEFAULT 0 NOT NULL CHECK (favorite IN (0, 1)), '
        'serial TEXT, '
        'description TEXT, '
        'qr TEXT UNIQUE, '
        'created_by TEXT NOT NULL, '
        'created_at TEXT NOT NULL, '
        'updated_by TEXT NOT NULL, '
        'updated_at TEXT NOT NULL'
        ');');

    // Apart from thumbnail, an item can have multiple images
    db.execute('CREATE TABLE images ('
        'id INTEGER PRIMARY KEY, '
        // items are the main entity
        // so, deleting an item will have cascading effect on all other entities
        'item_id INTEGER NOT NULL REFERENCES items(id) ON DELETE CASCADE, '
        'filename TEXT NOT NULL, '
        'file_location TEXT NOT NULL UNIQUE, '
        'created_by TEXT NOT NULL, '
        'created_at TEXT NOT NULL, '
        'updated_by TEXT NOT NULL, '
        'updated_at TEXT NOT NULL'
        ');');

    // Tags are another way of categorizing items
    await db.execute('CREATE TABLE tags ('
        'id INTEGER PRIMARY KEY, '
        'name TEXT NOT NULL UNIQUE, '
        'created_by TEXT NOT NULL, '
        'created_at TEXT NOT NULL, '
        'updated_by TEXT NOT NULL, '
        'updated_at TEXT NOT NULL'
        ');');

    // An item can have multiple tags
    // A tag can be used by multiple items
    await db.execute('CREATE TABLE items_tags ('
        'PRIMARY KEY (item_id, tag_id), '
        // items are the main entity
        // so, deleting an item will have cascading effect on all other entities
        'item_id INTEGER REFERENCES items(id) ON DELETE CASCADE, '
        'tag_id INTEGER NOT NULL REFERENCES tags(id) ON DELETE RESTRICT'
        ');');
  }
}
