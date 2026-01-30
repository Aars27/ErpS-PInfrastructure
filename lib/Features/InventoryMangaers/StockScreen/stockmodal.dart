class StockModel {
  final int id;
  final String status;
  final int currentStock;
  final int minimumThreshold;
  final String materialName;
  final String materialCode;
  final String unit;
  final String category;

  StockModel({
    required this.id,
    required this.status,
    required this.currentStock,
    required this.minimumThreshold,
    required this.materialName,
    required this.materialCode,
    required this.unit,
    required this.category,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    final material = json['material'];

    return StockModel(
      id: json['id'],
      status: json['status'],
      currentStock: json['current_stock'],
      minimumThreshold: json['minimum_threshold_quantity'],
      materialName: material['name'],
      materialCode: material['material_code'],
      unit: material['unit']['name'],
      category: material['category']['name'],
    );
  }
}
