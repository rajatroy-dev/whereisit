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

  Future<List<Item>> findItemsWithLocationPropertyRoomCategory(int id) async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('''
      SELECT items.id, items.name, items.thumbnail, items.quantity, items.favorite,
      items.serial, items.description, items.qr, items.created_by, items.created_at,
      items.updated_by, items.updated_at,
      locations.id, locations.latitude, locations.longitude, locations.address, 
      properties.id, properties.name,
      rooms.id, rooms.name,
      categories.id, categories.parent, categories.name
      FROM items
      INNER JOIN locations ON items.location_id = locations.id
      INNER JOIN properties ON items.property_id = properties.id
      INNER JOIN rooms ON items.room_id = rooms.id
      INNER JOIN categories ON items.category_id = categories.id
      WHERE items.id = ?
    ''', [id]);

    List<Item> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Item.fromMap(res[index]));
    }

    return list;
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
}
