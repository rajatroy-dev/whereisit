// To parse this JSON data, do
//
//     final image = imageFromMap(jsonString);

import 'dart:convert';

Image imageFromMap(String str) => Image.fromMap(json.decode(str));

String imageToMap(Image data) => json.encode(data.toMap());

class Image {
  Image({
    required this.id,
    required this.filename,
    required this.filelocation,
  });

  final int id;
  final String filename;
  final String filelocation;

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        filename: json["filename"],
        filelocation: json["filelocation"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "filename": filename,
        "filelocation": filelocation,
      };
}
