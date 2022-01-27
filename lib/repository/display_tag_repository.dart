import '../dao/display_tag_dao.dart';
import '../model/display_tag.dart';

class DisplayTagRepository {
  final dao = DisplayTagDao();

  Future<List<DisplayTag>> findByItemId(int id) => dao.findByItemId(id);
}
