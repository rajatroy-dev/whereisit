import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'base.dart';
import '../db/db_response.dart';
import '../models/image.model.dart';
import '../repository/image_repository.dart';

class ImageBloc implements Bloc {
  final _imageController = StreamController<DBResponse<Image>>.broadcast();

  get stream => _imageController.stream;

  Future<void> addImage(Image image) async {
    _imageController.sink
        .add(DBResponse.loading('Inserting image to db . . .'));

    var imageRepo = ImageRepository();
    try {
      int imageId = await imageRepo.insert(image);
      image.id = imageId;
      _imageController.sink.add(DBResponse.completed(image));
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        _imageController.sink.add(DBResponse.error('Image already exists!'));
      }
    }
  }

  @override
  void dispose() {
    _imageController.close();
  }
}
