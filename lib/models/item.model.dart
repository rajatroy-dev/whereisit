import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/models/cat_subcat.model.dart';
import 'package:whereisit/models/tag.model.dart';

class Item {
  Item({
    this.id,
    this.locationId,
    this.propertyId,
    this.roomId,
    this.categoryId,
    required this.name,
    required this.thumbnail,
    this.quantity,
    this.favorite,
    this.serial,
    this.description,
    this.qr,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    //--------------- ONLY FOR UI USE ---------------
    this.uiName,
    this.uiTagsList,
    this.uiImagesList,
    this.uiSelectedCategory,
    this.uiCardData,
    this.uiTagCount,
    this.uiError,
    this.uiCatSubcat,
    this.uiCoordinates,
    this.uiSearchedAddresses,
    this.uiAddress,
    this.uiSearchedProperties,
    this.uiProperty,
    //--------------- ONLY FOR UI USE ---------------
  });

  int? id;
  int? locationId;
  int? propertyId;
  int? roomId;
  int? categoryId;
  final String name;
  final String thumbnail;
  int? quantity;
  int? favorite;
  String? serial;
  String? description;
  String? qr;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  //--------------- ONLY FOR UI USE ---------------
  String? uiName;
  List<Tag>? uiTagsList;
  List<String>? uiImagesList;
  String? uiSelectedCategory;
  CardData? uiCardData;
  int? uiTagCount;
  String? uiError;
  CatSubcat? uiCatSubcat;
  LatLng? uiCoordinates;
  List<String>? uiSearchedAddresses;
  String? uiAddress;
  List<String>? uiSearchedProperties;
  String? uiProperty;
  //--------------- ONLY FOR UI USE ---------------

  Item copyWith({
    int? id,
    int? locationId,
    int? propertyId,
    int? roomId,
    int? categoryId,
    String? name,
    String? thumbnail,
    int? quantity,
    int? favorite,
    String? serial,
    String? description,
    String? qr,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? updatedBy,
  }) =>
      Item(
        id: id ?? this.id,
        locationId: locationId ?? this.locationId,
        propertyId: propertyId ?? this.propertyId,
        roomId: roomId ?? this.roomId,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        thumbnail: thumbnail ?? this.thumbnail,
        quantity: quantity ?? this.quantity,
        favorite: favorite ?? this.favorite,
        serial: serial ?? this.serial,
        description: description ?? this.description,
        qr: qr ?? this.qr,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        locationId: json["location_id"],
        propertyId: json["property_id"],
        roomId: json["room_id"],
        categoryId: json["category_id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        quantity: json["quantity"],
        favorite: json["favorite"],
        serial: json["serial"],
        description: json["description"],
        qr: json["qr"],
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
        updatedAt: json["updatedAt"],
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "location_id": locationId,
        "property_id": propertyId,
        "room_id": roomId,
        "category_id": categoryId,
        "name": name,
        "thumbnail": thumbnail,
        "quantity": quantity,
        "favorite": favorite,
        "serial": serial,
        "description": description,
        "qr": qr,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
      };

  factory Item.forUi(Map<String, dynamic> json) => Item(
        id: json["id"],
        locationId: json["location_id"],
        propertyId: json["property_id"],
        roomId: json["room_id"],
        categoryId: json["category_id"],
        name: json["name"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        quantity: json["quantity"],
        favorite: json["favorite"],
        serial: json["serial"],
        description: json["description"],
        qr: json["qr"],
        createdAt: DateTime.tryParse(json["createdAt"]) ?? DateTime.now(),
        createdBy: json["createdBy"] ?? 0,
        updatedAt: DateTime.tryParse(json["updatedAt"]) ?? DateTime.now(),
        updatedBy: json["updatedBy"] ?? 0,
        //--------------- ONLY FOR UI USE ---------------
        uiName: json['uiName'] ?? '',
        uiTagsList: json['uiTagsList'] ?? [],
        uiImagesList: json['uiImagesList'] ?? [],
        uiSelectedCategory: json['uiSelectedCategory'] ?? '',
        uiCardData: json['uiCardData'] ??
            CardData(
              id: '',
              imageSrc: '',
              qty: 0,
              location: '',
              tags: [],
              title: '',
              createdAt: '',
            ),
        uiTagCount: json['uiTagCount'] ?? 0,
        uiError: json['uiError'] ?? '',
        uiCatSubcat: json['uiCatSubcat'] ??
            CatSubcat(
              categories: [],
              subcategories: {},
            ),
        uiCoordinates: json['uiCoordinates'] ??
            const LatLng(
              -95.67127985317049,
              37.05311669685229,
            ),
        uiSearchedAddresses: json['uiSearchedAddresses'] ?? [],
        uiAddress: json['uiAddress'] ?? '',
        uiSearchedProperties: json['uiSearchedProperties'] ?? [],
        uiProperty: json['uiProperty'] ?? '',
        //--------------- ONLY FOR UI USE ---------------
      );
}
