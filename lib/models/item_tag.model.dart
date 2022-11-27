// To parse this JSON data, do
//
//     final itemTag = itemTagFromMap(jsonString);

import 'dart:convert';

ItemTag itemTagFromMap(String str) => ItemTag.fromMap(json.decode(str));

String itemTagToMap(ItemTag data) => json.encode(data.toMap());

class ItemTag {
  ItemTag({
    this.id,
    this.itemId,
    required this.tagId,
  });

  int? id;
  int? itemId;
  final int tagId;

  factory ItemTag.fromMap(Map<String, dynamic> json) => ItemTag(
        id: json["id"],
        itemId: json["item_id"],
        tagId: json["tag_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "item_id": itemId,
        "tag_id": tagId,
      };
}
