class GRNModel {
  final int id;
  final String grnNo;
  final String prCode;
  final String projectName;
  final String date;
  final List<GRNItem> items;

  GRNModel({
    required this.id,
    required this.grnNo,
    required this.prCode,
    required this.projectName,
    required this.date,
    required this.items,
  });
}

class GRNItem {
  final String materialName;
  final int orderedQty;
  final int receivedQty;

  GRNItem({
    required this.materialName,
    required this.orderedQty,
    required this.receivedQty,
  });
}
