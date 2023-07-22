import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'base.dart';
import '../data/db_response.dart';
import '../models/item.model.dart';
import '../data/repository/item_repository.dart';

class ItemBloc implements Bloc {
  final _itemController = StreamController<DatabaseResponse<Item>>.broadcast();

  get stream => _itemController.stream;

  Future<void> addItem(Item item) async {
    _itemController.sink
        .add(DatabaseResponse.loading('Inserting item to db . . .'));

    var itemRepo = ItemRepository();
    try {
      int itemId = await itemRepo.insert(item);
      item.id = itemId;
      _itemController.sink.add(DatabaseResponse.completed(item));
    } on DatabaseException catch (e) {
      _itemController.sink.add(DatabaseResponse.error(e.toString()));
    }
  }

  @override
  void dispose() {
    _itemController.close();
  }
}
