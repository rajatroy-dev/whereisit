import 'package:whereisit/models/item_with_location_propert_room_category_tag.model.dart';

import '../dao/item_dao.dart';
import '../../models/item.model.dart';

class ItemRepository {
  final dao = ItemDao();

  Future<int> insert(Item item) => dao.insert(item);
  Future<Item> findById(int id) => dao.findById(id);
  Future<List<Item>> findAll() => dao.findAll();
  Future<List<Item>> findItemsByTag(int id) => dao.findItemsByTag(id);
  Future<ItemWithLocationPropertyRoomCategoryTag?>
      findItemWithLocationPropertyRoomCategoryTagById(int id) =>
          dao.findItemWithLocationPropertyRoomCategoryTagById(id);
  Future<int> update(Item item) => dao.update(item);
  Future<int> delete(int id) => dao.delete(id);
}
