import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/tag.dart';

class TagDB {
  insert(Tag tag) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('tags', tag.toMap());
  }

  read(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  readAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('tags');
    List<Tag> list =
        res.isNotEmpty ? res.map((e) => Tag.fromMap(e)).toList() : [];

    return list;
  }

  update(Tag tag) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'tags',
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
