import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/room.model.dart';

class RoomDao {
  Future<int> insert(Room room) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('properties', room.toMap());
  }

  Future<Room> findById(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    ) as Room;
  }

  Future<List<Room>> findAll() async {
    Database db = await DBProvider.instance.db;

    var res = await db.query('properties');
    List<Room> list =
        res.isNotEmpty ? res.map((e) => Room.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Room room) async {
    Database db = await DBProvider.instance.db;

    return db.update(
      'properties',
      room.toMap(),
      where: 'id = ?',
      whereArgs: [room.id],
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
