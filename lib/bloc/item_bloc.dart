import 'dart:async';

import 'base.dart';

import '../repository/item_repository.dart';
import '../model/item.dart';

class ItemBloc implements Bloc {
  final _itemController = StreamController<Item>.broadcast();

  get itemStream => _itemController.stream;

  Future<void> createItem(Item item) async {
    var itemRepo = ItemRepository();
    int itemId = await itemRepo.insert(item);
    item.id = itemId;
    _itemController.sink.add(item);
  }

  @override
  void dispose() {
    _itemController.close();
  }
}
