// To parse this JSON data, do
//
//     final item = itemFromMap(jsonString);

import 'dart:convert';

Item itemFromMap(String str) => Item.fromMap(json.decode(str));

String itemToMap(Item data) => json.encode(data.toMap());

class Item {
  Item({
    this.id,
    this.propertyId,
    this.roomId,
    this.categoryId,
    required this.name,
    required this.thumbnail,
    this.quantity,
    this.favorite,
    this.serial,
    this.description,
    this.locationId,
    this.qr,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? propertyId;
  int? roomId;
  int? categoryId;
  final String name;
  final String thumbnail;
  int? quantity;
  int? favorite;
  int? locationId;
  String? serial;
  String? description;
  String? qr;
  final int createdAt;
  final int updatedAt;

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        propertyId: json["property_id"],
        roomId: json["room_id"],
        categoryId: json["category_id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        quantity: json["quantity"],
        favorite: json["favorite"],
        locationId: json["location_id"],
        serial: json["serial"],
        description: json["description"],
        qr: json["qr"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "property_id": propertyId,
        "room_id": roomId,
        "category_id": categoryId,
        "name": name,
        "thumbnail": thumbnail,
        "quantity": quantity,
        "favorite": favorite,
        "location_id": locationId,
        "serial": serial,
        "description": description,
        "qr": qr,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
