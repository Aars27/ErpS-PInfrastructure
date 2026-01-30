


import 'Grn_modal.dart';

class GRNController {
  /// Approved PR → Create GRN (dummy)
  GRNModel getApprovedPRForGRN() {
    return GRNModel(
      id: 1,
      grnNo: 'AUTO-GENERATED',
      prCode: 'PR-2024-001',
      projectName: 'Highway Project',
      date: '2024-01-25',
      items: [
        GRNItem(
          materialName: 'Cement',
          orderedQty: 500,
          receivedQty: 0,
        ),
        GRNItem(
          materialName: 'Steel',
          orderedQty: 200,
          receivedQty: 0,
        ),
      ],
    );
  }

  /// GRN History (dummy)
  List<GRNModel> getGRNHistory() {
    return [
      GRNModel(
        id: 101,
        grnNo: 'GRN-2024-001',
        prCode: 'PR-2024-001',
        projectName: 'Highway Project',
        date: '2024-01-26',
        items: [
          GRNItem(
            materialName: 'Cement',
            orderedQty: 500,
            receivedQty: 500,
          ),
        ],
      ),
      GRNModel(
        id: 102,
        grnNo: 'GRN-2024-002',
        prCode: 'PR-2024-002',
        projectName: 'Bridge Project',
        date: '2024-01-27',
        items: [
          GRNItem(
            materialName: 'Sand',
            orderedQty: 1000,
            receivedQty: 980,
          ),
        ],
      ),
    ];
  }
}
