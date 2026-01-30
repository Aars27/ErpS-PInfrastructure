class InventoryHistoryModel {
  final String material;
  final int quantity;
  final String type; // IN / OUT
  final String date;

  InventoryHistoryModel({
    required this.material,
    required this.quantity,
    required this.type,
    required this.date,
  });
}
