class ItemTag {
  ItemTag({
    this.id,
    required this.itemId,
    required this.tagId,
  });

  int? id;
  final int itemId;
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
