


import 'package:smp_erp/Features/InventoryDashoboardddddd/Inventoryscreenim/pr_modal.dart';

class PRApprovalController {
  /// 🔹 Dummy PR list
  List<PRModel> getPendingPRs() {
    return [
      PRModel(
        id: 1,
        prCode: 'PR-2024-001',
        projectName: 'Highway Project',
        urgency: 'HIGH',
        status: 'PENDING',
        date: '2024-01-20',
        materials: [
          PRMaterialModel(
            materialName: 'Cement',
            quantity: 500,
            requiredDate: '2024-01-25',
          ),
          PRMaterialModel(
            materialName: 'Steel',
            quantity: 200,
            requiredDate: '2024-01-26',
          ),
        ],
      ),
      PRModel(
        id: 2,
        prCode: 'PR-2024-002',
        projectName: 'Bridge Project',
        urgency: 'MEDIUM',
        status: 'PENDING',
        date: '2024-01-22',
        materials: [
          PRMaterialModel(
            materialName: 'Sand',
            quantity: 1000,
            requiredDate: '2024-01-28',
          ),
        ],
      ),
    ];
  }
}
