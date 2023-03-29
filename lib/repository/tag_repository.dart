import '../dao/tag_dao.dart';
import '../models/tag_dao.model.dart';

class TagRepository {
  final dao = TagDao();

  Future<int> insert(TagModel tag) => dao.insert(tag);
  Future<TagModel> findById(int id) => dao.findById(id);
  Future<List<TagModel>> findAll() => dao.findAll();
  Future<int> update(TagModel tag) => dao.update(tag);
  Future<int> delete(int id) => dao.delete(id);
}
