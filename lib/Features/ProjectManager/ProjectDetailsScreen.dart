import 'package:flutter/material.dart';
import 'DPR/DPRHistory/DPRDetailsScreen.dart';
import 'DPR/DPRHistory/DPRHistory.dart';
import 'DPR/CreateDpRScreen.dart';
import 'PrGenrate/screenview.dart';
import 'ProjectModal.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text(project.projectName,style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFFF15716),
      ),



      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// =====================
            /// PROJECT SUMMARY CARD
            /// =====================
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoRow(Icons.badge, 'Project Code', project.projectCode),
                    _infoRow(Icons.category, 'Type', project.projectType),
                    _infoRow(Icons.business, 'Client', project.client),
                    _infoRow(Icons.flag, 'Status', project.status),
                    _infoRow(
                        Icons.trending_up, 'Progress', '${project.progress}%'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// =====================
            /// LOCATION (EXPANDABLE)
            /// =====================
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 2,
              child: ExpansionTile(
                leading: const Icon(Icons.location_on,
                    color: Color(0xFFF15716)),
                title: const Text(
                  'Project Location',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  _simpleRow('State', project.state),
                  _simpleRow('District', project.district),
                  _simpleRow('Village', project.village),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// =====================
            /// ACTION BUTTONS
            /// =====================
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    icon: Icons.assignment,
                    label: 'Create PR',
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreatePRScreen(projectId: project.id),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(
                    icon: Icons.description,
                    label: 'DPR History',
                    color: Colors.blue,
                    onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder:
                        (context)=> DPRHistoryScreen()));
                      },

                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: _actionButton(
                icon: Icons.timeline,
                label: 'Create DPR',
                color: Colors.deepPurple,
                onTap: () {
                 Navigator.push(context,
                     MaterialPageRoute(builder:
                         (context)=> CreateDPRScreen(projectId: 1) ));

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =====================
  /// INFO ROW WITH ICON
  /// =====================
  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  /// =====================
  /// SIMPLE LOCATION ROW
  /// =====================
  Widget _simpleRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(title, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  /// =====================
  /// ACTION BUTTON
  /// =====================
  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: onTap,
    );
  }
}
