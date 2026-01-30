class PRMaterialItemModel {
  final String materialName;
  final String materialCode;
  final String unit;
  final String quantity;
  final DateTime requiredDate;

  PRMaterialItemModel({
    required this.materialName,
    required this.materialCode,
    required this.unit,
    required this.quantity,
    required this.requiredDate,
  });

  factory PRMaterialItemModel.fromJson(Map<String, dynamic> json) {
    final material = json['material'];

    return PRMaterialItemModel(
      materialName: material['name'],
      materialCode: material['material_code'],
      unit: material['unit']['name'],
      quantity: json['quantity'],
      requiredDate: DateTime.parse(json['required_date']),
    );
  }
}
