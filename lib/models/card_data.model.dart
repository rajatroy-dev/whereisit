// To parse this JSON data, do
//
//     final cardData = cardDataFromJson(jsonString);

import 'dart:convert';

CardData cardDataFromJson(String str) => CardData.fromJson(json.decode(str));

String cardDataToJson(CardData data) => json.encode(data.toJson());

class CardData {
  final String id;
  final String imageSrc;
  final String title;
  final String location;
  final int qty;
  final List<String> tags;
  bool? isFavorite;

  CardData({
    required this.id,
    required this.imageSrc,
    required this.title,
    required this.location,
    required this.qty,
    required this.tags,
    this.isFavorite,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        id: json["id"],
        imageSrc: json["imageSrc"],
        title: json["title"],
        location: json["location"],
        qty: json["qty"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        isFavorite: json.containsKey("isFavorite") ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageSrc": imageSrc,
        "title": title,
        "location": location,
        "qty": qty,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "isFavorite": isFavorite ?? false,
      };
}
