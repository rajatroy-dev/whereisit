// To parse this JSON data, do
//
//     final room = roomFromMap(jsonString);

import 'dart:convert';

Room roomFromMap(String str) => Room.fromMap(json.decode(str));

String roomToMap(Room data) => json.encode(data.toMap());

class Room {
  Room({
    this.id,
    required this.name,
  });

  String? id;
  final String name;

  factory Room.fromMap(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
