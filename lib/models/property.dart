// To parse this JSON data, do
//
//     final property = propertyFromMap(jsonString);

import 'dart:convert';

Property propertyFromMap(String str) => Property.fromMap(json.decode(str));

String propertyToMap(Property data) => json.encode(data.toMap());

class Property {
  Property({
    required this.id,
    required this.property,
  });

  final String id;
  final String property;

  factory Property.fromMap(Map<String, dynamic> json) => Property(
        id: json["id"],
        property: json["property"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "property": property,
      };
}
