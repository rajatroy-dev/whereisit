class Location {
  Location({
    this.id,
    this.latitude,
    this.longitude,
    required this.address,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
  });

  int? id;
  String? latitude;
  String? longitude;
  final String address;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;

  Location copyWith({
    int? id,
    String? latitude,
    String? longitude,
    String? address,
    String? name,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? updatedBy,
  }) =>
      Location(
        id: id ?? this.id,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address ?? this.address,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
        updatedAt: json["updatedAt"],
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
      };
}
