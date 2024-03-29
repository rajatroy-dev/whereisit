import '../dao/property_dao.dart';
import '../../models/property.model.dart';

class PropertyRepository {
  final dao = PropertyDao();

  Future<int> insert(Property property) => dao.insert(property);
  Future<Property?> findById(int id) => dao.findById(id);
  Future<int> getTotalProperties() => dao.getTotalProperties();
  Future<List<Property>> findByIds(List<int> ids) => dao.findByIds(ids);
  Future<List<Property>> findAll() => dao.findAll();
  Future<int> update(Property property) => dao.update(property);
  Future<int> delete(int id) => dao.delete(id);
}
