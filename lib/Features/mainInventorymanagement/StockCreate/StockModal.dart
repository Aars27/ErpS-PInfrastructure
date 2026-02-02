class StockModel {
  final int materialId;
  final int locationId;
  final String status;
  final int minimumThresholdQuantity;
  final int currentStock;
  final int quantity;
  final String specifications;


  StockModel({
    required this.materialId,
    required this.locationId,
    required this.status,
    required this.minimumThresholdQuantity,
    required this.currentStock,
    required this.quantity,
    required this.specifications,
  });


  Map<String, dynamic> toJson() {
    return {
      "material_id": materialId,
      "locationId": locationId,
      "status": status,
      "minimum_threshold_quantity": minimumThresholdQuantity,
      "current_stock": currentStock,
      "quantity": quantity,
      "specifications": specifications,
    };
  }
}
