import 'dart:async';

import 'base.dart';

import '../db/item_db.dart';
import '../models/item.dart';

class ItemBloc implements Bloc {
  final _itemController = StreamController<Item>.broadcast();

  get itemStream => _itemController.stream;

  Future<void> createItem(Item item) async {
    var itemDb = ItemDB();
    int itemId = await itemDb.insert(item);
    item.id = itemId;
    _itemController.sink.add(item);
  }

  @override
  void dispose() {
    _itemController.close();
  }
}
