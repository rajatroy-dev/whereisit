import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../model/location.dart';

class LocationDao {
  Future<int> insert(Location location) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('locations', location.toMap());
  }

  Future<Location> findById(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    ) as Location;
  }

  Future<List<Location>> findAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('locations');
    List<Location> list =
        res.isNotEmpty ? res.map((e) => Location.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Location location) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'locations',
      location.toMap(),
      where: 'id = ?',
      whereArgs: [location.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await DBProvider.instance.db;

    return db.delete(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
