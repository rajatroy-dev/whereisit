import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final pathToDatabase = join(databasePath, 'whereisit.db');

    var openDb = await openDatabase(
      pathToDatabase,
      version: 1,
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
    await db.execute(createUsersTable);

    DateTime now = DateTime.now();
    String isoDate = now.toIso8601String();

    await db.insert('users', {
      'name': 'System',
      'username': 'system',
      'created_by': 'system',
      'created_at': isoDate,
      'updated_by': 'system',
      'updated_at': isoDate,
    });

    // location is like a geographical location
    // It will have an address
    // It can also have co-ordinates
    await db.execute(createLocationsTable);

    // A house property could be your home, an office, a shop, a building or
    // some land attached to the building like a parking lot.
    await db.execute(createPropertiesTable);

    // Room exists in a property
    await db.execute(createRoomsTable);

    // The items stored will normally be categorized like books, electronics ...
    await db.execute(createCategoriesTable);

    await db.insert('categories', {
      'name': 'Uncategorized',
      'created_by': 'system',
      'created_at': isoDate,
      'updated_by': 'system',
      'updated_at': isoDate,
    });

    // Items are the things that are stored
    await db.execute(createItemsTable);

    // Apart from thumbnail, an item can have multiple images
    // items are the main entity
    // so, deleting an item will have cascading effect on all other entities
    db.execute(createImagesTable);

    // Tags are another way of categorizing items
    await db.execute(createTagsTable);

    // An item can have multiple tags
    // A tag can be used by multiple items
    // items are the main entity
    // so, deleting an item will have cascading effect on all other entities
    await db.execute(createItemTagTable);
  }

  static const createUsersTable = '''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      username TEXT NOT NULL UNIQUE,
      created_by TEXT NOT NULL REFERENCES users(username),
      created_at TEXT NOT NULL,
      updated_by TEXT NOT NULL REFERENCES users(username),
      updated_at TEXT NOT NULL
    )
  ''';

  static const createLocationsTable = '''
    CREATE TABLE locations (
      id INTEGER PRIMARY KEY,
      latitude TEXT,
      longitude TEXT,
      address TEXT NOT NULL UNIQUE,
      created_by TEXT NOT NULL REFERENCES users(username),
      created_at TEXT NOT NULL,
      updated_by TEXT NOT NULL REFERENCES users(username),
      updated_at TEXT NOT NULL
    )
  ''';

  static const createPropertiesTable = '''
    CREATE TABLE properties (
      id INTEGER PRIMARY KEY,
      location_id INTEGER REFERENCES locations(id) ON DELETE RESTRICT,
      name TEXT NOT NULL UNIQUE,
      created_by TEXT NOT NULL REFERENCES users(username),
      created_at TEXT NOT NULL,
      updated_by TEXT NOT NULL REFERENCES users(username),
      updated_at TEXT NOT NULL
    )
  ''';

  static const createRoomsTable = '''
    CREATE TABLE rooms (
      id INTEGER PRIMARY KEY,
      property_id INTEGER REFERENCES properties(id) ON DELETE RESTRICT,
      name TEXT NOT NULL,
      created_by TEXT NOT NULL REFERENCES users(username),
      created_at TEXT NOT NULL,
      updated_by TEXT NOT NULL REFERENCES users(username),
      updated_at TEXT NOT NULL
    )
  ''';

  static const createCategoriesTable = '''
    CREATE TABLE categories (
      id INTEGER PRIMARY KEY,
      parent_category TEXT,
      name TEXT NOT NULL UNIQUE,
      created_by TEXT NOT NULL REFERENCES users(username),
      created_at TEXT NOT NULL,
      updated_by TEXT NOT NULL REFERENCES users(username),
      updated_at TEXT NOT NULL
    )
  ''';

  static const createItemsTable = '''
    CREATE TABLE items (
      id INTEGER PRIMARY KEY,
      location_id INTEGER REFERENCES locations(id) ON DELETE RESTRICT,
      property_id INTEGER REFERENCES properties(id) ON DELETE RESTRICT,
      room_id INTEGER REFERENCES rooms(id) ON DELETE RESTRICT,
      category_id INTEGER DEFAULT 1 NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
      name TEXT NOT NULL,
      thumbnail TEXT NOT NULL,
      quantity INTEGER DEFAULT 1 NOT NULL,
      favorite INTEGER DEFAULT 0 NOT NULL CHECK (favorite IN (0, 1)),
      serial TEXT,
      description TEXT,
      qr TEXT UNIQUE,
      created_by TEXT NOT NULL REFERENCES users(username),
      created_at TEXT NOT NULL,
      updated_by TEXT NOT NULL REFERENCES users(username),
      updated_at TEXT NOT NULL
    )
  ''';

  static const createImagesTable = '''
    CREATE TABLE images (
      id INTEGER PRIMARY KEY,
      item_id INTEGER NOT NULL REFERENCES items(id) ON DELETE CASCADE,
      filename TEXT NOT NULL,
      file_location TEXT NOT NULL UNIQUE,
      created_by TEXT NOT NULL REFERENCES users(username),
      created_at TEXT NOT NULL,
      updated_by TEXT NOT NULL REFERENCES users(username),
      updated_at TEXT NOT NULL
    )
  ''';

  static const createTagsTable = '''
    CREATE TABLE tags (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL UNIQUE,
      tag_count INTEGER DEFAULT 0,
      created_by TEXT NOT NULL REFERENCES users(username),
      created_at TEXT NOT NULL,
      updated_by TEXT NOT NULL REFERENCES users(username),
      updated_at TEXT NOT NULL
    )
  ''';

  static const createItemTagTable = '''
    CREATE TABLE item_tag (
      item_id INTEGER REFERENCES items(id) ON DELETE CASCADE,
      tag_id INTEGER NOT NULL REFERENCES tags(id) ON DELETE RESTRICT,
      PRIMARY KEY (item_id, tag_id)
    )
  ''';
}
