import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/item.dart';

class ItemDB {
  insert(Item item) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('items', item.toMap());
  }

  read(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  readAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('items');
    List<Item> list =
        res.isNotEmpty ? res.map((e) => Item.fromMap(e)).toList() : [];

    return list;
  }

  update(Item item) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
