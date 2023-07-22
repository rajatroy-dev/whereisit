import '../database.dart';
import '../../models/property.model.dart';

class PropertyDao {
  Future<int> insert(Property property) async {
    final db = await DatabaseProvider.database;

    return await db.insert('properties', property.toMap());
  }

  Future<Property> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    ) as Property;
  }

  Future<List<Property>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query('properties');
    List<Property> list =
        res.isNotEmpty ? res.map((e) => Property.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Property property) async {
    final db = await DatabaseProvider.database;

    return db.update(
      'properties',
      property.toMap(),
      where: 'id = ?',
      whereArgs: [property.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return db.delete(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
