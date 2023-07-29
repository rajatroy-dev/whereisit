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

  Future<Item> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    ) as Item;
  }

  Future<List<Item>> findItemsByTag(int id) async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('''
      SELECT items.id, items.name, items.thumbnail, items.quantity, items.favorite
      FROM items
      INNER JOIN item_tag ON items.id = item_tag.item_id
      WHERE item_tag.item_id = ?
    ''', [id]);

    List<Item> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Item.fromMap(res[index]));
    }

    return list;
  }

// item_with_location_propert_room_category_tag
  Future<ItemWithLocationPropertyRoomCategoryTag?>
      findItemWithLocationPropertyRoomCategoryTagById(
    int id,
  ) async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('''
      SELECT items.id, items.name, items.thumbnail, items.quantity, items.favorite,
        items.serial, items.description, items.qr, items.created_by, items.created_at,
        items.updated_by, items.updated_at,
        locations.id, locations.latitude, locations.longitude, locations.address, 
        properties.id, properties.name,
        rooms.id, rooms.name,
        categories.id, categories.parent, categories.name,
        tags.id, tags.name, tags.tag_count
      FROM items
      INNER JOIN locations ON items.location_id = locations.id
      INNER JOIN properties ON items.property_id = properties.id
      INNER JOIN rooms ON items.room_id = rooms.id
      INNER JOIN categories ON items.category_id = categories.id
      INNER JOIN item_tag ON items.id = item_tag.item_id
      INNER JOIN tags ON item_tag.tag_id = tags.id
      WHERE items.id = ?
    ''', [id]);

    if (res.isNotEmpty) {
      final map = res.first;
      return ItemWithLocationPropertyRoomCategoryTag(
        itemId: map['items.id'] as int,
        itemName: map['items.name'] as String,
        itemThumbnail: map['items.thumbnail'] as String,
        itemQuantity: map['items.quantity'] as int,
        itemFavorite: map['items.favorite'] == 1,
        itemSerial: map['items.serial'] as String? ?? '',
        itemDescription: map['items.description'] as String? ?? '',
        itemQr: map['items.qr'] as String? ?? '',
        itemCreatedBy: map['items.created_by'] as String,
        itemCreatedAt: _parseDateTime(map['items.created_at']),
        itemUpdatedBy: map['items.updated_by'] as String,
        itemUpdatedAt: _parseDateTime(map['items.updated_at']),
        locationId: map['locations.id'] as int? ?? -1,
        locationLatitude: map['locations.latitude'] as double? ?? -100,
        locationLongitude: map['locations.longitude'] as double? ?? -200,
        locationAddress: map['locations.address'] as String? ?? '',
        propertyId: map['properties.id'] as int? ?? -1,
        propertyName: map['properties.name'] as String? ?? '',
        roomId: map['rooms.id'] as int? ?? -1,
        roomName: map['rooms.name'] as String? ?? '',
        categoryId: map['categories.id'] as int? ?? -1,
        categoryParent: map['categories.parent'] as int? ?? -1,
        categoryName: map['categories.name'] as String? ?? '',
        tagId: map['tags.id'] as int? ?? -1,
        tagName: map['tags.name'] as String? ?? '',
        tagCount: map['tags.tag_count'] as int? ?? -1,
      );
    }

    return null;
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
