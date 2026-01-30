


import 'Dashboard_modal.dart';

class InventoryDashboardController {
  /// 🔹 Dummy dashboard data (mock JSON)
  List<DashboardCardModel> getDashboardCards() {
    return [
      DashboardCardModel(
        title: 'Pending PR Approvals',
        count: 5,
        route: '/pr-approval',
        icon: 'approval',
      ),
      DashboardCardModel(
        title: 'Create GRN',
        count: 2,
        route: '/grn',
        icon: 'grn',
      ),
      DashboardCardModel(
        title: 'Projects',
        count: 8,
        route: '/projects',
        icon: 'project',
      ),
      DashboardCardModel(
        title: 'Inventory History',
        count: 120,
        route: '/inventory-history',
        icon: 'history',
      ),
    ];
  }
}
