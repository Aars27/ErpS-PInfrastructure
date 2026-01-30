import 'package:flutter/material.dart';
import 'package:smp_erp/Features/InventoryDashoboardddddd/Inventoryscreenim/pr_modal.dart';

class PRDetailScreen extends StatelessWidget {
  final PRModel pr;

  const PRDetailScreen({super.key, required this.pr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text(pr.prCode),
        backgroundColor: const Color(0xFFFC6911),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _info('Project', pr.projectName),
            _info('Urgency', pr.urgency),
            _info('Status', pr.status),
            const SizedBox(height: 20),

            const Text(
              'Materials',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ...pr.materials.map(
                  (m) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(m.materialName),
                  subtitle: Text(
                      'Qty: ${m.quantity}\nRequired: ${m.requiredDate}'),
                ),
              ),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('PR Approved')),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Approve'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('PR Rejected')),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
