import '../dao/display_item_dao.dart';
import '../model/display_item.dart';

class DisplayItemRepository {
  final dao = DisplayItemDao();

  Future<DisplayItem> findByItemId(int id) => dao.findByItemId(id);
}
