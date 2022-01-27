import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../model/property.dart';

class PropertyDao {
  Future<int> insert(Property property) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('properties', property.toMap());
  }

  Future<Property> findById(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    ) as Property;
  }

  Future<List<Property>> findAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('properties');
    List<Property> list =
        res.isNotEmpty ? res.map((e) => Property.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Property property) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'properties',
      property.toMap(),
      where: 'id = ?',
      whereArgs: [property.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
