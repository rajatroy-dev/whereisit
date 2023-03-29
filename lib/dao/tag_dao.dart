import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/tag_dao.model.dart';

class TagDao {
  Future<int> insert(TagModel tag) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('tags', tag.toMap());
  }

  Future<TagModel> findById(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    ) as TagModel;
  }

  Future<List<TagModel>> findAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('tags');
    List<TagModel> list =
        res.isNotEmpty ? res.map((e) => TagModel.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(TagModel tag) async {
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
