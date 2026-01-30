import 'package:flutter/material.dart';

import 'GrnController.dart';
import 'Grn_modal.dart';




class GRNCreateScreen extends StatefulWidget {
  const GRNCreateScreen({super.key});

  @override
  State<GRNCreateScreen> createState() => _GRNCreateScreenState();
}

class _GRNCreateScreenState extends State<GRNCreateScreen> {
  final GRNController _controller = GRNController();
  late GRNModel grn;

  @override
  void initState() {
    super.initState();
    grn = _controller.getApprovedPRForGRN();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Create GRN'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _info('PR Code', grn.prCode),
            _info('Project', grn.projectName),
            _info('Date', grn.date),
            const SizedBox(height: 16),

            const Text(
              'Materials Received',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: grn.items.length,
                itemBuilder: (context, index) {
                  final item = grn.items[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.materialName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text('Ordered Qty: ${item.orderedQty}'),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Received Qty',
                            ),
                            onChanged: (v) {
                              setState(() {
                                grn.items[index] = GRNItem(
                                  materialName: item.materialName,
                                  orderedQty: item.orderedQty,
                                  receivedQty: int.tryParse(v) ?? 0,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(14),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('GRN Created (Dummy)')),
                );
                Navigator.pop(context);
              },
              child: const Center(child: Text('Submit GRN')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text('$label: $value'),
    );
  }
}
