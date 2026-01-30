




import 'Inventory_history_model.dart';
import 'dpr_view_model.dart';
import 'modelproject.dart';

class ProjectController {

  List<ProjectModel> getProjects() {
    return [
      ProjectModel(id: 1, name: 'Highway Project', code: 'HW-01'),
      ProjectModel(id: 2, name: 'Bridge Project', code: 'BR-02'),
    ];
  }

  List<InventoryHistoryModel> getInventoryHistory(int projectId) {
    return [
      InventoryHistoryModel(
        material: 'Cement',
        quantity: 500,
        type: 'IN',
        date: '2024-01-20',
      ),
      InventoryHistoryModel(
        material: 'Steel',
        quantity: 200,
        type: 'OUT',
        date: '2024-01-22',
      ),
    ];
  }

  List<DPRViewModel> getDPRs(int projectId) {
    return [
      DPRViewModel(
        date: '2024-01-15',
        remarks: 'Foundation work completed',
        totalCost: 100000,
      ),
      DPRViewModel(
        date: '2024-01-16',
        remarks: 'Pillar work ongoing',
        totalCost: 75000,
      ),
    ];
  }
}
