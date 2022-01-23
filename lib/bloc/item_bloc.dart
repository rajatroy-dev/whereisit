import 'dart:async';

import 'base.dart';

import '../db/item_db.dart';
import '../models/item.dart';

class ItemBloc implements Bloc {
  final _itemController = StreamController<Item>.broadcast();

  get itemStream => _itemController.stream;

  Future<void> getItem(Item item) async {
    var itemDb = ItemDB();
    _itemController.sink.add(await itemDb.insert(item));
  }

  @override
  void dispose() {
    _itemController.close();
  }
}
