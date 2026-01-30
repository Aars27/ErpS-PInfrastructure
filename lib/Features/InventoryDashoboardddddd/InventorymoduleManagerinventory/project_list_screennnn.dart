import 'package:flutter/material.dart';
import 'package:smp_erp/Features/InventoryDashoboardddddd/InventorymoduleManagerinventory/project_controller.dart';
import 'package:smp_erp/Features/InventoryDashoboardddddd/InventorymoduleManagerinventory/projeeect_detailsss_screeen.dart';






class ProjectListScreen extends StatelessWidget {
  ProjectListScreen({super.key});

  final controller = ProjectController();

  @override
  Widget build(BuildContext context) {
    final projects = controller.getProjects();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: projects.length,
        itemBuilder: (_, i) {
          final p = projects[i];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Code: ${p.code}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProjectDetailScreen(project: p),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
