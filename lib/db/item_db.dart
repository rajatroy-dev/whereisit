import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/item.dart';

class ItemDB {
  insert(Item item) async {
    Database db = await DBProvider.instance.db;

    return await db.insert('items', item.toMap());
  }
}
