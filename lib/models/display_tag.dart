// To parse this JSON data, do
//
//     final displayTag = displayTagFromMap(jsonString);

import 'dart:convert';

DisplayTag displayTagFromMap(String str) =>
    DisplayTag.fromMap(json.decode(str));

String displayTagToMap(DisplayTag data) => json.encode(data.toMap());

class DisplayTag {
  DisplayTag({
    required this.id,
    required this.itemId,
    required this.tag,
  });

  final int id;
  final int itemId;
  final String tag;

  factory DisplayTag.fromMap(Map<String, dynamic> json) => DisplayTag(
        id: json["id"],
        itemId: json["item_id"],
        tag: json["tag"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "item_id": itemId,
        "tag": tag,
      };
}
