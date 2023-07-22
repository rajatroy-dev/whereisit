import '../dao/category_dao.dart';
import '../../models/category.model.dart';

class CategoryRepository {
  final dao = CategoryDao();

  Future<int> insert(Category category) => dao.insert(category);
  Future<Category> findById(int id) => dao.findById(id);
  Future<List<Category>> findAll() => dao.findAll();
  Future<int> update(Category category) => dao.update(category);
  Future<int> delete(int id) => dao.delete(id);
}
