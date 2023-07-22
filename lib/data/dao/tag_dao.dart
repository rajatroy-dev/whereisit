import '../database.dart';
import '../../models/tag_dao.model.dart';

class TagDao {
  Future<int> insert(TagModel tag) async {
    final db = await DatabaseProvider.database;

    return await db.insert('tags', tag.toMap());
  }

  Future<TagModel> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    ) as TagModel;
  }

  Future<List<TagModel>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query('tags');
    List<TagModel> list =
        res.isNotEmpty ? res.map((e) => TagModel.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(TagModel tag) async {
    final db = await DatabaseProvider.database;

    return db.update(
      'tags',
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return db.delete(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
