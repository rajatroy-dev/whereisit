import '../database.dart';
import '../../models/tag.model.dart';

class TagDao {
  static const String table = 'tags';

  Future<int> insert(Tag tag) async {
    final db = await DatabaseProvider.database;
    final now = DateTime.now();

    tag = tag.copyWith(
      createdAt: now,
      updatedAt: now,
      // TODO: Currently we are only considering system user
      createdBy: 'system',
      updatedBy: 'system',
    );

    return await db.insert(table, tag.toMap());
  }

  Future<Tag> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    ) as Tag;
  }

  Future<List<Tag>> findTagsByItem(int id) async {
    final db = await DatabaseProvider.database;

    final res = await db.rawQuery('''
      SELECT tags.id, tags.name, tags.count
      FROM tags
      INNER JOIN item_tag ON tags.id = item_tag.tag_id
      WHERE item_tag.tag_id = ?
    ''', [id]);

    List<Tag> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Tag.fromMap(res[index]));
    }

    return list;
  }

  Future<List<Tag>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query(table);
    List<Tag> list = [];
    if (res.isNotEmpty) {
      list = List.generate(res.length, (index) => Tag.fromMap(res[index]));
    }

    return list;
  }

  Future<int> update(Tag tag) async {
    final db = await DatabaseProvider.database;
    final now = DateTime.now();

    tag = tag.copyWith(
      // TODO: Currently we are only considering system user
      updatedAt: now,
    );

    return await db.update(
      table,
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
