import 'package:sqflite/sqflite.dart';

import '../database.dart';
import '../../models/room.model.dart';

class RoomDao {
  static const String table = 'room';

  Future<int> insert(Room room) async {
    final db = await DatabaseProvider.database;

    return await db.insert(table, room.toMap());
  }

  Future<Room?> findById(int id) async {
    final db = await DatabaseProvider.database;

    final res = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (res.isEmpty) return null;

    return Room.fromMap(res.first);
  }

  Future<int> getTotalRooms() async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('SELECT COUNT(*) FROM $table');
    int? count = Sqflite.firstIntValue(res);

    return count ?? 0;
  }

  Future<List<Room>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query(table);
    List<Room> list = res.isNotEmpty
        ? List.generate(res.length, (index) => Room.fromMap(res[index]))
        : [];

    return list;
  }

  Future<int> update(Room room) async {
    final db = await DatabaseProvider.database;
    final now = DateTime.now();

    room = room.copyWith(
      // TODO: Currently we are only considering system user
      updatedAt: now,
    );

    return db.update(
      table,
      room.toMap(),
      where: 'id = ?',
      whereArgs: [room.id],
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
