import 'package:flutter/material.dart';
import 'package:smp_erp/Features/InventoryDashoboardddddd/InventorymoduleManagerinventory/project_controller.dart';

import 'modelproject.dart';





class ProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;
  ProjectDetailScreen({super.key, required this.project});

  final controller = ProjectController();

  @override
  Widget build(BuildContext context) {
    final inventory = controller.getInventoryHistory(project.id);
    final dprs = controller.getDPRs(project.id);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          title: Text(project.name),
          backgroundColor: const Color(0xFF0F172A),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Inventory History'),
              Tab(text: 'DPR View'),
            ],
          ),
        ),
        body: TabBarView(
          children: [

            /// INVENTORY HISTORY
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: inventory.length,
              itemBuilder: (_, i) {
                final h = inventory[i];
                return Card(
                  child: ListTile(
                    title: Text(h.material),
                    subtitle: Text('${h.type} • ${h.date}'),
                    trailing: Text(
                      h.quantity.toString(),
                      style: TextStyle(
                        color: h.type == 'IN' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            /// DPR VIEW
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dprs.length,
              itemBuilder: (_, i) {
                final d = dprs[i];
                return Card(
                  child: ListTile(
                    title: Text(d.date),
                    subtitle: Text(d.remarks),
                    trailing: Text(
                      '₹${d.totalCost}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
