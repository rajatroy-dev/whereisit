// To parse this JSON data, do
//
//     final tag = tagFromMap(jsonString);

import 'dart:convert';

TagModel tagFromMap(String str) => TagModel.fromMap(json.decode(str));

String tagToMap(TagModel data) => json.encode(data.toMap());

class TagModel {
  TagModel({
    this.id,
    required this.name,
  });

  String? id;
  final String name;

  factory TagModel.fromMap(Map<String, dynamic> json) => TagModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
