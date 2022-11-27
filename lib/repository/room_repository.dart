import '../dao/room_dao.dart';
import '../models/room.model.dart';

class RoomRepository {
  final dao = RoomDao();

  Future<int> insert(Room room) => dao.insert(room);
  Future<Room> findById(int id) => dao.findById(id);
  Future<List<Room>> findAll() => dao.findAll();
  Future<int> update(Room room) => dao.update(room);
  Future<int> delete(int id) => dao.delete(id);
}
