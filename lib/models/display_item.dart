// To parse this JSON data, do
//
//     final displayItem = displayItemFromMap(jsonString);

import 'dart:convert';

DisplayItem displayItemFromMap(String str) =>
    DisplayItem.fromMap(json.decode(str));

String displayItemToMap(DisplayItem data) => json.encode(data.toMap());

class DisplayItem {
  DisplayItem({
    required this.id,
    this.property,
    this.room,
    required this.category,
    required this.name,
    required this.thumbnail,
    required this.quantity,
    required this.favorite,
    this.address,
    this.serial,
    this.description,
    this.qr,
  });

  final int id;
  String? property;
  String? room;
  final String category;
  final String name;
  final String thumbnail;
  final int quantity;
  final int favorite;
  String? address;
  String? serial;
  String? description;
  String? qr;

  factory DisplayItem.fromMap(Map<String, dynamic> json) => DisplayItem(
        id: json["id"],
        property: json["property"],
        room: json["room"],
        category: json["category"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        quantity: json["quantity"],
        favorite: json["favorite"],
        address: json["address"],
        serial: json["serial"],
        description: json["description"],
        qr: json["qr"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "property": property,
        "room": room,
        "category": category,
        "name": name,
        "thumbnail": thumbnail,
        "quantity": quantity,
        "favorite": favorite,
        "address": address,
        "serial": serial,
        "description": description,
        "qr": qr,
      };
}
