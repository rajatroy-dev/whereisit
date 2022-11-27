// To parse this JSON data, do
//
//     final image = imageFromMap(jsonString);

import 'dart:convert';

Image imageFromMap(String str) => Image.fromMap(json.decode(str));

String imageToMap(Image data) => json.encode(data.toMap());

class Image {
  Image({
    this.id,
    required this.itemId,
    required this.filename,
    required this.filelocation,
  });

  int? id;
  final int itemId;
  final String filename;
  final String filelocation;

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        itemId: json["item_id"],
        filename: json["filename"],
        filelocation: json["filelocation"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "item_id": itemId,
        "filename": filename,
        "filelocation": filelocation,
      };
}
