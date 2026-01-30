class PRModel {
  final int id;
  final String prCode;
  final String status;
  final String urgencyLevel;
  final String remarks;
  final int itemsCount;
  final String totalQuantity;
  final List<PRItemModel> items;

  PRModel({
    required this.id,
    required this.prCode,
    required this.status,
    required this.urgencyLevel,
    required this.remarks,
    required this.itemsCount,
    required this.totalQuantity,
    required this.items,
  });

  factory PRModel.fromJson(Map<String, dynamic> json) {
    return PRModel(
      id: json['id'],
      prCode: json['pr_code'],
      status: json['status'],
      urgencyLevel: json['urgency_level'],
      remarks: json['remarks'] ?? '',
      itemsCount: json['material_items_count'],
      totalQuantity: json['total_quantity'].toString(),
      items: (json['material_items'] as List)
          .map((e) => PRItemModel.fromJson(e))
          .toList(),
    );
  }
}

class PRItemModel {
  final String materialName;
  final String materialCode;
  final String quantity;
  final String unit;

  PRItemModel({
    required this.materialName,
    required this.materialCode,
    required this.quantity,
    required this.unit,
  });

  factory PRItemModel.fromJson(Map<String, dynamic> json) {
    return PRItemModel(
      materialName: json['material']['name'],
      materialCode: json['material']['material_code'],
      quantity: json['quantity'],
      unit: json['material']['unit']['name'],
    );
  }
}
