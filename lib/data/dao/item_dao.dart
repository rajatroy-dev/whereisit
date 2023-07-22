import '../database.dart';
import '../../models/item.model.dart';

class ItemDao {
  Future<int> insert(Item item) async {
    final db = await DatabaseProvider.database;

    return await db.insert('items', item.toMap());
  }

  Future<Item> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    ) as Item;
  }

  Future<List<Item>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query('items');
    List<Item> list =
        res.isNotEmpty ? res.map((e) => Item.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Item item) async {
    final db = await DatabaseProvider.database;

    return db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
