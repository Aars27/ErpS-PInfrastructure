class MaterialModel {
  final int id;
  final String name;
  final String materialCode;
  final String status;
  final int minThreshold;
  final String categoryName;
  final String unitName;
  final DateTime createdAt;

  MaterialModel({
    required this.id,
    required this.name,
    required this.materialCode,
    required this.status,
    required this.minThreshold,
    required this.categoryName,
    required this.unitName,
    required this.createdAt,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'],
      name: json['name'],
      materialCode: json['material_code'],
      status: json['status'],
      minThreshold: json['minimum_threshold_quantity'],
      categoryName: json['category']['name'],
      unitName: json['unit']['name'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
