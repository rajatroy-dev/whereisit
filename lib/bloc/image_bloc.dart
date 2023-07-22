import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'base.dart';
import '../data/db_response.dart';
import '../models/image.model.dart';
import '../data/repository/image_repository.dart';

class ImageBloc implements Bloc {
  final _imageController =
      StreamController<DatabaseResponse<Image>>.broadcast();

  get stream => _imageController.stream;

  Future<void> addImage(Image image) async {
    _imageController.sink
        .add(DatabaseResponse.loading('Inserting image to db . . .'));

    var imageRepo = ImageRepository();
    try {
      int imageId = await imageRepo.insert(image);
      image.id = imageId;
      _imageController.sink.add(DatabaseResponse.completed(image));
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        _imageController.sink
            .add(DatabaseResponse.error('Image already exists!'));
      }
    }
  }

  @override
  void dispose() {
    _imageController.close();
  }
}
