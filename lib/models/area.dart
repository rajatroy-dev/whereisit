// To parse this JSON data, do
//
//     final area = areaFromMap(jsonString);

import 'dart:convert';

Area areaFromMap(String str) => Area.fromMap(json.decode(str));

String areaToMap(Area data) => json.encode(data.toMap());

class Area {
  Area({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Area.fromMap(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
