class Property {
  Property({
    this.id,
    this.locationId,
    required this.name,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
  });

  final int? id;
  final int? locationId;
  final String name;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;

  Property copyWith({
    int? id,
    int? locationId,
    String? name,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? updatedBy,
  }) =>
      Property(
        id: id ?? this.id,
        locationId: locationId ?? this.locationId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory Property.fromMap(Map<String, dynamic> json) => Property(
        id: json["id"],
        locationId: json["location_id"],
        name: json["name"],
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
        updatedAt: json["updatedAt"],
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "location_id": locationId,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
      };
}
