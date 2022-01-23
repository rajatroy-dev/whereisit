// To parse this JSON data, do
//
//     final item = itemFromMap(jsonString);

import 'dart:convert';

Item itemFromMap(String str) => Item.fromMap(json.decode(str));

String itemToMap(Item data) => json.encode(data.toMap());

class Item {
  Item({
    required this.id,
    this.property,
    this.room,
    this.area,
    required this.name,
    this.serial,
    this.description,
    required this.quantity,
    required this.thumbnail,
    this.images,
    this.location,
    required this.favorite,
    this.qr,
    this.tags,
  });

  final String id;
  String? property;
  String? room;
  String? area;
  final String name;
  String? serial;
  String? description;
  final int quantity;
  final String thumbnail;
  List<String>? images;
  String? location;
  final bool favorite;
  String? qr;
  List<String>? tags;

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        property: json["property"],
        room: json["room"],
        area: json["area"],
        name: json["name"],
        serial: json["serial"],
        description: json["description"],
        quantity: json["quantity"],
        thumbnail: json["thumbnail"],
        images:
            json["images"] ?? List<String>.from(json["images"].map((x) => x)),
        location: json["location"],
        favorite: json["favorite"],
        qr: json["qr"],
        tags: json["tags"] ?? List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "property": property,
        "room": room,
        "area": area,
        "name": name,
        "serial": serial,
        "description": description,
        "quantity": quantity,
        "thumbnail": thumbnail,
        "images": images ?? List<String>.from(images!.map((x) => x)),
        "location": location,
        "favorite": favorite,
        "qr": qr,
        "tags": tags ?? List<String>.from(tags!.map((x) => x)),
      };
}
