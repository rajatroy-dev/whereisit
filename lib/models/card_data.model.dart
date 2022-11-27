// To parse this JSON data, do
//
//     final cardData = cardDataFromJson(jsonString);

import 'dart:convert';

CardData cardDataFromJson(String str) => CardData.fromJson(json.decode(str));

String cardDataToJson(CardData data) => json.encode(data.toJson());

class CardData {
  CardData({
    required this.title,
    required this.location,
    required this.qty,
    required this.tags,
  });

  final String title;
  final String location;
  final int qty;
  final List<String> tags;

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        title: json["title"],
        location: json["location"],
        qty: json["qty"],
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
        "qty": qty,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}
