import '../database.dart';
import '../../models/location.model.dart';

class LocationDao {
  Future<int> insert(Location location) async {
    final db = await DatabaseProvider.database;

    return await db.insert('locations', location.toMap());
  }

  Future<Location> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    ) as Location;
  }

  Future<List<Location>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query('locations');
    List<Location> list =
        res.isNotEmpty ? res.map((e) => Location.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Location location) async {
    final db = await DatabaseProvider.database;

    return db.update(
      'locations',
      location.toMap(),
      where: 'id = ?',
      whereArgs: [location.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return db.delete(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
