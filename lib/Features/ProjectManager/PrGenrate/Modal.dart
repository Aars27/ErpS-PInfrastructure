import '../MaterialScreen/NewMaterialModal.dart';

class PRMaterialForm {
  MaterialItem? material;
  String? quantity;
  DateTime? requiredDate;

  Map<String, dynamic> toJson() {
    return {
      "material_id": material!.id,
      "quantity": quantity!,
      "required_date":
      "${requiredDate!.year.toString().padLeft(4, '0')}-"
          "${requiredDate!.month.toString().padLeft(2, '0')}-"
          "${requiredDate!.day.toString().padLeft(2, '0')}",
    };
  }
}




class PurchaseRequisition {
  final int projectId;
  final String prCode;
  final String prType;
  final String urgency;
  final String remarks;
  final List<PRMaterialForm> materials;
  final int userId;

  PurchaseRequisition({
    required this.projectId,
    required this.prCode,
    required this.prType,
    required this.urgency,
    required this.remarks,
    required this.materials,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      "project_id": projectId,
      "pr_code": prCode,
      "pr_type": prType,
      "urgency_level": urgency,
      "status": "DRAFT",
      "remarks": remarks,
      "user_id": userId,
      "approved_by": null,
      "send_to": null,
      "material_items": materials.map((m) => m.toJson()).toList(),
    };
  }
}





