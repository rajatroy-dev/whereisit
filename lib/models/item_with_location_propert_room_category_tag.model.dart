class ItemWithLocationPropertyRoomCategoryTag {
  final int itemId;
  final String itemName;
  final String itemThumbnail;
  final int itemQuantity;
  final bool itemFavorite;
  final String itemSerial;
  final String itemDescription;
  final String itemQr;
  final String itemCreatedBy;
  final DateTime itemCreatedAt;
  final String itemUpdatedBy;
  final DateTime itemUpdatedAt;
  final int locationId;
  final double locationLatitude;
  final double locationLongitude;
  final String locationAddress;
  final int propertyId;
  final String propertyName;
  final int roomId;
  final String roomName;
  final int categoryId;
  final int categoryParent;
  final String categoryName;
  final int tagId;
  final String tagName;
  final int tagCount;

  ItemWithLocationPropertyRoomCategoryTag({
    required this.itemId,
    required this.itemName,
    required this.itemThumbnail,
    required this.itemQuantity,
    required this.itemFavorite,
    required this.itemSerial,
    required this.itemDescription,
    required this.itemQr,
    required this.itemCreatedBy,
    required this.itemCreatedAt,
    required this.itemUpdatedBy,
    required this.itemUpdatedAt,
    required this.locationId,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.locationAddress,
    required this.propertyId,
    required this.propertyName,
    required this.roomId,
    required this.roomName,
    required this.categoryId,
    required this.categoryParent,
    required this.categoryName,
    required this.tagId,
    required this.tagName,
    required this.tagCount,
  });
}
