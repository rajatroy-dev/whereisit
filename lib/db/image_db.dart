import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/image.dart';

class ImageDB {
  insert(Image image) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('images', image.toMap());
  }

  read(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'images',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  readAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('images');
    List<Image> list =
        res.isNotEmpty ? res.map((e) => Image.fromMap(e)).toList() : [];

    return list;
  }

  update(Image image) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'images',
      image.toMap(),
      where: 'id = ?',
      whereArgs: [image.id],
    );
  }

  delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'images',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
