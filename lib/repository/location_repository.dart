import '../dao/location_dao.dart';
import '../models/location.model.dart';

class LocationRepository {
  final dao = LocationDao();

  Future<int> insert(Location location) => dao.insert(location);
  Future<Location> findById(int id) => dao.findById(id);
  Future<List<Location>> findAll() => dao.findAll();
  Future<int> update(Location location) => dao.update(location);
  Future<int> delete(int id) => dao.delete(id);
}
