import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../model/item.dart';

class ItemDao {
  Future<int> insert(Item item) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('items', item.toMap());
  }

  Future<Item> findById(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    ) as Item;
  }

  Future<List<Item>> findAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('items');
    List<Item> list =
        res.isNotEmpty ? res.map((e) => Item.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Item item) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
