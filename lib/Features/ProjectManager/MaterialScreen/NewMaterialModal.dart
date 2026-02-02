class MaterialItem {
  final int id;
  final String name;
  final String code;
  final String unit;
  final int minQty;

  MaterialItem({
    required this.id,
    required this.name,
    required this.code,
    required this.unit,
    required this.minQty,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      id: json['id'],
      name: json['name'],
      code: json['material_code'],
      unit: json['unit']['name'],
      minQty: json['minimum_threshold_quantity'],
    );
  }
}