import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/display_tag.dart';

class DisplayTagDB {
  Future<List<DisplayTag>> findByItemId(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
        'SELECT '
        'items_tags.id AS id, '
        'items_tags.item_id AS item_id, '
        'tags.name AS tag '
        'FROM '
        'item_tags '
        'INNER JOIN tags ON items_tags.tag_id = tags.id',
        where: 'items_tags.item_id = ?',
        whereArgs: [id]) as List<DisplayTag>;
  }
}
