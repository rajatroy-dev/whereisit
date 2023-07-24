import '../dao/tag_dao.dart';
import '../../models/tag.model.dart';

class TagRepository {
  final dao = TagDao();

  Future<int> insert(Tag tag) => dao.insert(tag);
  Future<Tag> findById(int id) => dao.findById(id);
  Future<List<Tag>> findAll() => dao.findAll();
  Future<int> update(Tag tag) => dao.update(tag);
  Future<int> delete(int id) => dao.delete(id);
}
