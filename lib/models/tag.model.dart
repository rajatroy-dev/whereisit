class Tag {
  int id;
  String name;
  int? tagCount;
  String createdBy;
  DateTime createdAt;
  String updatedBy;
  DateTime updatedAt;

  Tag({
    required this.id,
    required this.name,
    this.tagCount,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  Tag copyWith({
    int? id,
    String? name,
    int? tagCount,
    String? createdBy,
    DateTime? createdAt,
    String? updatedBy,
    DateTime? updatedAt,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        tagCount: tagCount ?? this.tagCount,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        tagCount: json["tag_count"],
        createdBy: json["created_by"],
        createdAt: DateTime.tryParse(json["created_at"]) ?? DateTime.now(),
        updatedBy: json["updated_by"],
        updatedAt: DateTime.tryParse(json["updated_at"]) ?? DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "tag_count": tagCount,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt.toIso8601String(),
      };
}
