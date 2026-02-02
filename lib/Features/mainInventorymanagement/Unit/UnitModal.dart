class UnitModel {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;

  UnitModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
