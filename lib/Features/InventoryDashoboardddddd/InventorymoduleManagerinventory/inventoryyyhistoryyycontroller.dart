
import 'inventoryhistoryyymodal.dart';

class InventoryHistoryController {
  List<InventoryHistoryModel> getHistory() {
    return [
      InventoryHistoryModel(
        itemName: 'Cement',
        action: 'IN',
        quantity: 100,
        date: '2024-01-10',
        reference: 'GRN-001',
        projectName: 'Highway Project',
      ),
      InventoryHistoryModel(
        itemName: 'Steel Rod',
        action: 'OUT',
        quantity: 40,
        date: '2024-01-12',
        reference: 'DPR-012',
        projectName: 'Bridge Project',
      ),
      InventoryHistoryModel(
        itemName: 'Sand',
        action: 'OUT',
        quantity: 200,
        date: '2024-01-15',
        reference: 'PR-021',
        projectName: 'Road Project',
      ),
    ];
  }
}
