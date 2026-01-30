import 'package:flutter/material.dart';
import 'inventory_history_model.dart';
import 'inventoryyyhistoryyycontroller.dart';

class InventoryHistoryScreen extends StatelessWidget {
  InventoryHistoryScreen({super.key});

  final InventoryHistoryController _controller =
  InventoryHistoryController();

  Color _getActionColor(String action) {
    return action == 'IN' ? Colors.green : Colors.red;
  }

  IconData _getActionIcon(String action) {
    return action == 'IN'
        ? Icons.arrow_downward_rounded
        : Icons.arrow_upward_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final history = _controller.getHistory();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Inventory History'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _getActionColor(item.action).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getActionIcon(item.action),
                    color: _getActionColor(item.action),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.itemName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Project: ${item.projectName}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _infoChip(item.reference),
                          const SizedBox(width: 8),
                          _infoChip(item.date),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  '${item.action} ${item.quantity}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getActionColor(item.action),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
