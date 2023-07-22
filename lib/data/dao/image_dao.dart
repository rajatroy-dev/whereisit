import '../database.dart';
import '../../models/image.model.dart';

class ImageDao {
  Future<int> insert(Image image) async {
    final db = await DatabaseProvider.database;

    return await db.insert('images', image.toMap());
  }

  Future<Image> findById(int id) async {
    final db = await DatabaseProvider.database;

    return await db.query(
      'images',
      where: 'id = ?',
      whereArgs: [id],
    ) as Image;
  }

  Future<List<Image>> findAll() async {
    final db = await DatabaseProvider.database;

    var res = await db.query('images');
    List<Image> list =
        res.isNotEmpty ? res.map((e) => Image.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> update(Image image) async {
    final db = await DatabaseProvider.database;

    return db.update(
      'images',
      image.toMap(),
      where: 'id = ?',
      whereArgs: [image.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;

    return db.delete(
      'images',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
