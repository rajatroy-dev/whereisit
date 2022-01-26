// To parse this JSON data, do
//
//     final location = locationFromMap(jsonString);

import 'dart:convert';

Location locationFromMap(String str) => Location.fromMap(json.decode(str));

String locationToMap(Location data) => json.encode(data.toMap());

class Location {
  Location({
    this.id,
    this.location,
    required this.address,
  });

  int? id;
  String? location;
  final String address;

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        id: json["id"],
        location: json["location"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "location": location,
        "address": address,
      };
}
