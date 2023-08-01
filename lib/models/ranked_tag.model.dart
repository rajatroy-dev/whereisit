class RankedTag {
  final int itemId;
  final String itemName;
  final String itemThumbnail;
  final int itemQuantity;
  final bool isItemFavorite;
  final int tagId;
  final String tagName;
  final int tagCount;

  RankedTag({
    required this.itemId,
    required this.itemName,
    required this.itemThumbnail,
    required this.itemQuantity,
    required this.isItemFavorite,
    required this.tagId,
    required this.tagName,
    required this.tagCount,
  });

  factory RankedTag.fromMap(Map<String, dynamic> map) {
    return RankedTag(
      itemId: map['item_id'] as int,
      itemName: map['item_name'] as String,
      itemThumbnail: map['item_thumbnail'] as String,
      itemQuantity: map['item_quantity'] as int,
      isItemFavorite: map['item_favorite'] as int == 1,
      tagId: map['tag_id'] as int,
      tagName: map['tag_name'] as String,
      tagCount: map['tag_count'] as int,
    );
  }
}
