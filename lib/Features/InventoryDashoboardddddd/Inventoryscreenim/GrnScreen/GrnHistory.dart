import 'package:flutter/material.dart';

import 'GrnController.dart';

class GRNHistoryScreen extends StatelessWidget {
  GRNHistoryScreen({super.key});

  final GRNController _controller = GRNController();

  @override
  Widget build(BuildContext context) {
    final grns = _controller.getGRNHistory();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('GRN History'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: grns.length,
        itemBuilder: (context, index) {
          final g = grns[index];

          return Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                g.grnNo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PR: ${g.prCode}'),
                  Text('Project: ${g.projectName}'),
                  Text('Date: ${g.date}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
