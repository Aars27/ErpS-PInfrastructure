import 'package:flutter/material.dart';
import 'package:smp_erp/Features/InventoryDashoboardddddd/Inventoryscreenim/pr_Details_Screen.dart';
import 'Pr_approval_controller.dart';


class PRApprovalListScreen extends StatelessWidget {
  PRApprovalListScreen({super.key});

  final PRApprovalController _controller = PRApprovalController();

  @override
  Widget build(BuildContext context) {
    final prs = _controller.getPendingPRs();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('PR Approvals'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: prs.length,
        itemBuilder: (context, index) {
          final pr = prs[index];

          return Card(
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                pr.prCode,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Project: ${pr.projectName}'),
                    Text('Urgency: ${pr.urgency}'),
                    Text('Date: ${pr.date}'),
                  ],
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PRDetailScreen(pr: pr),
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
