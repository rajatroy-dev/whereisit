import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/category.dart';

class CategoryDB {
  insert(Category category) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('categories', category.toMap());
  }

  read(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  readAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('categories');
    List<Category> list =
        res.isNotEmpty ? res.map((e) => Category.fromMap(e)).toList() : [];

    return list;
  }

  update(Category category) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
