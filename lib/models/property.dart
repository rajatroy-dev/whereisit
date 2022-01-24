// To parse this JSON data, do
//
//     final property = propertyFromMap(jsonString);

import 'dart:convert';

Property propertyFromMap(String str) => Property.fromMap(json.decode(str));

String propertyToMap(Property data) => json.encode(data.toMap());

class Property {
  Property({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Property.fromMap(Map<String, dynamic> json) => Property(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
