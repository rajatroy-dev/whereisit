import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/tag.model.dart';

class TagDao {
  Future<int> insert(Tag tag) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('tags', tag.toMap());
  }

  Future<Tag> findById(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    ) as Tag;
  }

  Future<List<Tag>> findAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('tags');
    List<Tag> list =
        res.isNotEmpty ? res.map((e) => Tag.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Tag tag) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'tags',
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
