import '../dao/item_dao.dart';
import '../../models/item.model.dart';

class ItemRepository {
  final dao = ItemDao();

  Future<int> insert(Item item) => dao.insert(item);
  Future<Item> findById(int id) => dao.findById(id);
  Future<List<Item>> findAll() => dao.findAll();
  Future<List<Item>> findItemsByTag(int id) => dao.findItemsByTag(id);
  Future<List<Item>> findItemsWithLocationPropertyRoomCategory(int id) =>
      dao.findItemsWithLocationPropertyRoomCategory(id);
  Future<int> update(Item item) => dao.update(item);
  Future<int> delete(int id) => dao.delete(id);
}