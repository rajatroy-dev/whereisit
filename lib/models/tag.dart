// To parse this JSON data, do
//
//     final tag = tagFromMap(jsonString);

import 'dart:convert';

Tag tagFromMap(String str) => Tag.fromMap(json.decode(str));

String tagToMap(Tag data) => json.encode(data.toMap());

class Tag {
  Tag({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
