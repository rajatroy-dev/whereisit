class Room {
  Room({
    this.id,
    this.propertyId,
    required this.name,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
  });

  final int? id;
  final int? propertyId;
  final String name;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;

  Room copyWith({
    int? id,
    int? propertyId,
    String? name,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? updatedBy,
  }) =>
      Room(
        id: id ?? this.id,
        propertyId: propertyId ?? this.propertyId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory Room.fromMap(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
        propertyId: json["property_id"],
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
        updatedAt: json["updatedAt"],
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "property_id": propertyId,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
      };
}
