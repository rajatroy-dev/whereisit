import '../dao/image_dao.dart';
import '../models/image.model.dart';

class ImageRepository {
  final dao = ImageDao();

  Future<int> insert(Image image) => dao.insert(image);
  Future<Image> findById(int id) => dao.findById(id);
  Future<List<Image>> findAll() => dao.findAll();
  Future<int> update(Image image) => dao.update(image);
  Future<int> delete(int id) => dao.delete(id);
}
