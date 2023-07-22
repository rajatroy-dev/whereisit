import '../database.dart';
import '../../models/room.model.dart';

class RoomDao {
  Future<int> insert(Room room) async {
    final db = await DatabaseProvider.database;

    return await db.insert('properties', room.toMap());
  }

  Future<Room> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    ) as Room;
  }

  Future<List<Room>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query('properties');
    List<Room> list =
        res.isNotEmpty ? res.map((e) => Room.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Room room) async {
    final db = await DatabaseProvider.database;

    return db.update(
      'properties',
      room.toMap(),
      where: 'id = ?',
      whereArgs: [room.id],
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
