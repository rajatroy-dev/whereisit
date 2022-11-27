import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/category.model.dart';

class CategoryDao {
  Future<int> insert(Category category) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('categories', category.toMap());
  }

  Future<Category> findById(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    ) as Category;
  }

  Future<List<Category>> findAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('categories');
    List<Category> list =
        res.isNotEmpty ? res.map((e) => Category.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Category category) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
