import 'package:sqflite/sqflite.dart';

import '../database.dart';
import '../../models/location.model.dart';

class LocationDao {
  static const String table = 'locations';

  Future<int> insert(Location location) async {
    final db = await DatabaseProvider.database;

    return await db.insert(table, location.toMap());
  }

  Future<Location?> findById(int id) async {
    final db = await DatabaseProvider.database;

    final res = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (res.isEmpty) return null;

    return Location.fromMap(res.first);
  }

  Future<List<Location>> findByIds(List<int> ids) async {
    final db = await DatabaseProvider.database;

    var placeHolders = ids.map((id) => '?').join(', ');

    final res = await db.query(
      table,
      where: 'id IN ($placeHolders)',
      whereArgs: ids,
    );

    List<Location> list = res.isNotEmpty
        ? List.generate(res.length, (index) => Location.fromMap(res[index]))
        : [];

    return list;
  }

  Future<int> getTotalLocations() async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('SELECT COUNT(*) FROM $table');
    int? count = Sqflite.firstIntValue(res);

    return count ?? 0;
  }

  Future<List<Location>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query(table);
    List<Location> list = res.isNotEmpty
        ? List.generate(res.length, (index) => Location.fromMap(res[index]))
        : [];

    return list;
  }

  Future<int> update(Location location) async {
    final db = await DatabaseProvider.database;
    final now = DateTime.now();

    location = location.copyWith(
      // TODO: Currently we are only considering system user
      updatedAt: now,
    );

    return db.update(
      table,
      location.toMap(),
      where: 'id = ?',
      whereArgs: [location.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
