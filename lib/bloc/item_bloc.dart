import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'base.dart';
import '../db/db_response.dart';
import '../model/item.dart';
import '../repository/item_repository.dart';

class ItemBloc implements Bloc {
  final _itemController = StreamController<DBResponse<Item>>.broadcast();

  get stream => _itemController.stream;

  Future<void> addItem(Item item) async {
    _itemController.sink.add(DBResponse.loading('Inserting item to db . . .'));

    var itemRepo = ItemRepository();
    try {
      int itemId = await itemRepo.insert(item);
      item.id = itemId;
      _itemController.sink.add(DBResponse.completed(item));
    } on DatabaseException catch (e) {
      _itemController.sink.add(DBResponse.error(e.toString()));
    }
  }

  @override
  void dispose() {
    _itemController.close();
  }
}
