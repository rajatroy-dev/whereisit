// To parse this JSON data, do
//
//     final room = roomFromMap(jsonString);

import 'dart:convert';

Room roomFromMap(String str) => Room.fromMap(json.decode(str));

String roomToMap(Room data) => json.encode(data.toMap());

class Room {
  Room({
    required this.id,
    required this.room,
  });

  final String id;
  final String room;

  factory Room.fromMap(Map<String, dynamic> json) => Room(
        id: json["id"],
        room: json["room"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "room": room,
      };
}
