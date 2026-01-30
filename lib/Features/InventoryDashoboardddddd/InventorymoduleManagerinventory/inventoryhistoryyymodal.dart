class InventoryHistoryModel {
  final String itemName;
  final String action; // IN / OUT
  final int quantity;
  final String date;
  final String reference; // PR / GRN / DPR
  final String projectName;

  InventoryHistoryModel({
    required this.itemName,
    required this.action,
    required this.quantity,
    required this.date,
    required this.reference,
    required this.projectName,
  });
}
