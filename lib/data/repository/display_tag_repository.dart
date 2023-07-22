import '../dao/display_tag_dao.dart';
import '../../models/display_tag.model.dart';

class DisplayTagRepository {
  final dao = DisplayTagDao();

  Future<List<DisplayTag>> findByItemId(int id) => dao.findByItemId(id);
}
