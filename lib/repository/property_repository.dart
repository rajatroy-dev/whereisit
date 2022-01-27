import '../dao/property_dao.dart';
import '../model/property.dart';

class PropertyRepository {
  final dao = PropertyDao();

  Future<int> insert(Property property) => dao.insert(property);
  Future<Property> findById(int id) => dao.findById(id);
  Future<List<Property>> findAll() => dao.findAll();
  Future<int> update(Property property) => dao.update(property);
  Future<int> delete(int id) => dao.delete(id);
}
