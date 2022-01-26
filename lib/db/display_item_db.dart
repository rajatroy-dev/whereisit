import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/display_item.dart';

class DisplayItemDB {
  Future<DisplayItem> findByItemId(int id) async {
    Database db = await DBProvider.instance.db;

    return await db.query(
        'SELECT '
        'items.id AS id, '
        'properties.name AS property, '
        'rooms.name AS room, '
        'categories.name AS category, '
        'items.name AS name, '
        'items.thumbnail AS thumbnail, '
        'items.quantity AS quantity, '
        'items.favorite AS favorite, '
        'locations.address AS address, '
        'items.serial AS serial, '
        'items.description AS description, '
        'items.qr AS qr '
        'FROM '
        'items '
        'INNER JOIN properties ON properties.id = items.property_id '
        'INNER JOIN rooms ON rooms.id = items.room_id '
        'INNER JOIN categories ON categories.id = items.category_id '
        'INNER JOIN locations ON locations.id = items.location_id',
        where: 'items.id = ?',
        whereArgs: [id]) as DisplayItem;
  }
}
