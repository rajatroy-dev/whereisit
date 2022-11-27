import '../dao/display_item_dao.dart';
import '../models/display_item.model.dart';

class DisplayItemRepository {
  final dao = DisplayItemDao();

  Future<DisplayItem> findByItemId(int id) => dao.findByItemId(id);
}
