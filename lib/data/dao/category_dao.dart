import '../database.dart';
import '../../models/category.model.dart';

class CategoryDao {
  Future<int> insert(Category category) async {
    final db = await DatabaseProvider.database;

    return await db.insert('categories', category.toMap());
  }

  Future<Category> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    ) as Category;
  }

  Future<List<Category>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query('categories');
    List<Category> list =
        res.isNotEmpty ? res.map((e) => Category.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Category category) async {
    final db = await DatabaseProvider.database;

    return db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
