import 'package:sqflite/sqflite.dart';

import '../database.dart';
import '../../models/property.model.dart';

class PropertyDao {
  static const String table = 'properties';

  Future<int> insert(Property property) async {
    final db = await DatabaseProvider.database;

    return await db.insert(table, property.toMap());
  }

  Future<Property?> findById(int id) async {
    final db = await DatabaseProvider.database;

    final res = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (res.isEmpty) return null;

    return Property.fromMap(res.first);
  }

  Future<int> getTotalProperties() async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('SELECT COUNT(*) FROM $table');
    int? count = Sqflite.firstIntValue(res);

    return count ?? 0;
  }

  Future<List<Property>> findByIds(List<int> ids) async {
    final db = await DatabaseProvider.database;

    var placeHolders = ids.map((id) => '?').join(', ');

    final res = await db.query(
      table,
      where: 'id IN ($placeHolders)',
      whereArgs: ids,
    );

    List<Property> list = res.isNotEmpty
        ? List.generate(res.length, (index) => Property.fromMap(res[index]))
        : [];

    return list;
  }

  Future<List<Property>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query(table);
    List<Property> list = res.isNotEmpty
        ? List.generate(res.length, (index) => Property.fromMap(res[index]))
        : [];

    return list;
  }

  Future<int> update(Property property) async {
    final db = await DatabaseProvider.database;
    final now = DateTime.now();

    property = property.copyWith(
      // TODO: Currently we are only considering system user
      updatedAt: now,
    );

    return db.update(
      table,
      property.toMap(),
      where: 'id = ?',
      whereArgs: [property.id],
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
