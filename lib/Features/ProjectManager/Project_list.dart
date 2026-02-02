import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProjectModal.dart';
import 'ProjectDetailsScreen.dart';
import 'Project_Controller.dart';



class ProjectScreen extends StatefulWidget {
  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectController>().fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProjectController>();

    return Scaffold(

      appBar: AppBar(title: const Text('All Project')),


      body: controller.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: controller.projects.length,
        itemBuilder: (context, index) {
          final Project project = controller.projects[index];

          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(project.projectName),
              subtitle: Text(project.projectCode),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProjectDetailScreen(project: project),
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
