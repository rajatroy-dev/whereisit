import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/property.dart';

class PropertyDB {
  insert(Property property) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('properties', property.toMap());
  }

  read(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  readAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('properties');
    List<Property> list =
        res.isNotEmpty ? res.map((e) => Property.fromMap(e)).toList() : [];

    return list;
  }

  update(Property property) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'properties',
      property.toMap(),
      where: 'id = ?',
      whereArgs: [property.id],
    );
  }

  delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
