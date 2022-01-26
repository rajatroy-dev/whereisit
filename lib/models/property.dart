// To parse this JSON data, do
//
//     final property = propertyFromMap(jsonString);

import 'dart:convert';

Property propertyFromMap(String str) => Property.fromMap(json.decode(str));

String propertyToMap(Property data) => json.encode(data.toMap());

class Property {
  Property({
    this.id,
    this.locationId,
    required this.name,
  });

  int? id;
  int? locationId;
  final String name;

  factory Property.fromMap(Map<String, dynamic> json) => Property(
        id: json["id"],
        locationId: json["location_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "location_id": locationId,
        "name": name,
      };
}
