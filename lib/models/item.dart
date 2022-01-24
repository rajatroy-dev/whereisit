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
    this.areaId,
    required this.name,
    required this.thumbnail,
    this.quantity,
    this.favorite,
    this.serial,
    this.description,
    this.location,
    this.address,
    this.qr,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? propertyId;
  int? roomId;
  int? areaId;
  final String name;
  final String thumbnail;
  int? quantity;
  int? favorite;
  String? serial;
  String? description;
  String? location;
  String? address;
  String? qr;
  final int createdAt;
  final int updatedAt;

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        propertyId: json["property_id"],
        roomId: json["room_id"],
        areaId: json["area_id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        quantity: json["quantity"],
        favorite: json["favorite"],
        serial: json["serial"],
        description: json["description"],
        location: json["location"],
        address: json["address"],
        qr: json["qr"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "property_id": propertyId,
        "room_id": roomId,
        "area_id": areaId,
        "name": name,
        "serial": serial,
        "description": description,
        "quantity": quantity,
        "thumbnail": thumbnail,
        "location": location,
        "address": address,
        "favorite": favorite,
        "qr": qr,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
