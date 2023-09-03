import 'package:sqflite/sqflite.dart';
import 'package:whereisit/data/db_response.dart';
import 'package:whereisit/models/item_with_location_propert_room_category_tag.model.dart';

import '../database.dart';
import '../../models/item.model.dart';

class ItemDao {
  static const String table = 'items';

  Future<int> insert(Item item) async {
    final db = await DatabaseProvider.database;
    final now = DateTime.now();

    item = item.copyWith(
      createdAt: now,
      updatedAt: now,
      // TODO: Currently we are only considering system user
      createdBy: 'system',
      updatedBy: 'system',
    );

    return await db.insert(table, item.toMap());
  }

  Future<Item?> findById(int id) async {
    final db = await DatabaseProvider.database;

    final res = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (res.isEmpty) return null;

    return Item.fromMap(res.first);
  }

  Future<DatabaseResponse> findItemsByTag(int id) async {
    final db = await DatabaseProvider.database;

    List<Map<String, Object?>> res;
    try {
      res = await db.rawQuery('''
        SELECT
          items.id,
          items.name,
          items.thumbnail,
          items.quantity,
          items.favorite
        FROM items
        INNER JOIN item_tag
          ON items.id = item_tag.item_id
        WHERE item_tag.item_id = ?
      ''', [id]);
    } catch (e) {
      return DatabaseResponse<String>.error(e.toString());
    }

    List<Item> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Item.fromMap(res[index]));
    }

    return DatabaseResponse.completed(list);
  }

  // item_with_location_propert_room_category_tag
  Future<ItemWithLocationPropertyRoomCategoryTag?>
      findItemWithLocationPropertyRoomCategoryTagById(
    int id,
  ) async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('''
      SELECT items.id AS items_id, items.name AS items_name,
        items.thumbnail AS items_thumbnail, items.quantity AS items_quantity,
        items.favorite AS items_favorite, items.serial AS items_serial,
        items.description AS items_description, items.qr AS items_qr,
        items.created_by AS items_created_by, items.created_at AS items_created_at,
        items.updated_by AS items_updated_by, items.updated_at AS items_updated_at,
        locations.id AS locations_id, locations.latitude AS locations_latitude,
        locations.longitude AS locations_longitude, locations.address AS locations_address, 
        properties.id AS properties_id, properties.name AS properties_name,
        rooms.id AS rooms_id, rooms.name AS rooms_name,
        categories.id AS categories_id, categories.parent AS categories_parent,
        categories.name AS categories_name,
        tags.id AS tags_id, tags.name AS tags_name, tags.tag_count AS tags_tag_count
      FROM items
      INNER JOIN locations ON items.location_id = locations.id
      INNER JOIN properties ON items.property_id = properties.id
      INNER JOIN rooms ON items.room_id = rooms.id
      INNER JOIN categories ON items.category_id = categories.id
      INNER JOIN item_tag ON items.id = item_tag.item_id
      INNER JOIN tags ON item_tag.tag_id = tags.id
      WHERE items.id = ?
    ''', [id]);

    if (res.isEmpty) return null;

    final map = res.first;
    return ItemWithLocationPropertyRoomCategoryTag(
      itemId: map['items_id'] as int,
      itemName: map['items_name'] as String,
      itemThumbnail: map['items_thumbnail'] as String,
      itemQuantity: map['items_quantity'] as int,
      itemFavorite: map['items_favorite'] == 1,
      itemSerial: map['items_serial'] as String? ?? '',
      itemDescription: map['items_description'] as String? ?? '',
      itemQr: map['items_qr'] as String? ?? '',
      itemCreatedBy: map['items_created_by'] as String,
      itemCreatedAt: _parseDateTime(map['items_created_at']),
      itemUpdatedBy: map['items_updated_by'] as String,
      itemUpdatedAt: _parseDateTime(map['items_updated_at']),
      locationId: map['locations_id'] as int? ?? -1,
      locationLatitude: map['locations_latitude'] as double? ?? -100,
      locationLongitude: map['locations_longitude'] as double? ?? -200,
      locationAddress: map['locations_address'] as String? ?? '',
      propertyId: map['properties_id'] as int? ?? -1,
      propertyName: map['properties_name'] as String? ?? '',
      roomId: map['rooms_id'] as int? ?? -1,
      roomName: map['rooms_name'] as String? ?? '',
      categoryId: map['categories_id'] as int? ?? -1,
      categoryParent: map['categories_parent'] as int? ?? -1,
      categoryName: map['categories_name'] as String? ?? '',
      tagId: map['tags_id'] as int? ?? -1,
      tagName: map['tags_name'] as String? ?? '',
      tagCount: map['tags_tag_count'] as int? ?? -1,
    );
  }

  Future<List<Item>> findLatestItems() async {
    final db = await DatabaseProvider.database;

    var res = await db.query(
      table,
      orderBy: 'updated_at DESC',
      limit: 5,
    );

    List<Item> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Item.fromMap(res[index]));
    }

    return list;
  }

  Future<List<Item>> findOldestItems() async {
    final db = await DatabaseProvider.database;

    var res = await db.query(
      table,
      orderBy: 'updated_at ASC',
      limit: 5,
    );

    List<Item> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Item.fromMap(res[index]));
    }

    return list;
  }

  Future<List<Item>> findFavoriteItems() async {
    final db = await DatabaseProvider.database;

    var res = await db.query(
      table,
      where: 'favorite = ?',
      whereArgs: [1],
      limit: 5,
    );

    List<Item> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Item.fromMap(res[index]));
    }

    return list;
  }

  Future<List<Item>> findItemsWithHighestTagCount() async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('''
        SELECT 
          items.id AS item_id,
          items.name AS item_name,
          items.thumbnail AS item_thumbnail,
          items.quantity AS item_quantity,
          items.favorite AS item_favorite,
          COUNT(item_tag.tag_id) AS tag_count
        FROM items
        INNER JOIN item_tag 
          ON items.id = item_tag.item_id
        GROUP BY items.id, items.name
        ORDER BY tag_count DESC
        LIMIT 5;
      ''');

    List<Item> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Item.fromMap(res[index]));
    }

    return list;
  }

  Future<List<int>> findItemsWithCategories() async {
    final db = await DatabaseProvider.database;

    // Category cannot be empty. Default is 1 (Uncategorized).
    var res = await db.query('SELECT category_id FROM $table');
    List<int> list = [];
    if (res.isNotEmpty) {
      list = List.generate(
        res.length,
        (index) => Item.fromMap(res[index]).categoryId!,
      );
    }

    return list;
  }

  Future<List<int>> findItemsWithLocations() async {
    final db = await DatabaseProvider.database;

    // Category cannot be empty. Default is 1 (Uncategorized).
    var res = await db.query(
      'SELECT location_id FROM $table',
      where: 'location_id != ?',
      whereArgs: [null],
    );
    List<int> list = [];
    if (res.isNotEmpty) {
      list = List.generate(
        res.length,
        (index) => Item.fromMap(res[index]).categoryId!,
      );
    }

    return list;
  }

  Future<int> getTotalItems() async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('SELECT COUNT(*) FROM $table');
    int? count = Sqflite.firstIntValue(res);

    return count ?? 0;
  }

  Future<List<Item>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query(table);
    List<Item> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Item.fromMap(res[index]));
    }

    return list;
  }

  Future<int> update(Item item) async {
    final db = await DatabaseProvider.database;
    final now = DateTime.now();

    item = item.copyWith(
      // TODO: Currently we are only considering system user
      updatedAt: now,
    );

    return await db.update(
      table,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  DateTime _parseDateTime(dynamic value) {
    if (value == null) {
      throw Exception('DateTime is null for the item.');
    }
    return DateTime.parse(value as String);
  }
}
