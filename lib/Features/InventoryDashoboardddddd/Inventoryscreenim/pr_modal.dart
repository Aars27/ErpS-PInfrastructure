class PRModel {
  final int id;
  final String prCode;
  final String projectName;
  final String urgency;
  final String status;
  final String date;
  final List<PRMaterialModel> materials;

  PRModel({
    required this.id,
    required this.prCode,
    required this.projectName,
    required this.urgency,
    required this.status,
    required this.date,
    required this.materials,
  });
}

class PRMaterialModel {
  final String materialName;
  final int quantity;
  final String requiredDate;

  PRMaterialModel({
    required this.materialName,
    required this.quantity,
    required this.requiredDate,
  });
}
