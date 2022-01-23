import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';
import '../models/item.dart';

class ItemDB {
  insert(Item item) async {
    Database? db = await DBProvider.db;

    return await db?.insert('items', item.toMap());
  }
}
