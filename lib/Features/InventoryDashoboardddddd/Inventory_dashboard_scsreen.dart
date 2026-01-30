import 'package:flutter/material.dart';

import 'Dashboard_controller.dart';
import 'Dashboard_modal.dart';




class InventoryDashboardScreen extends StatelessWidget {
  InventoryDashboardScreen({super.key});

  final InventoryDashboardController _controller =
  InventoryDashboardController();

  @override
  Widget build(BuildContext context) {
    final cards = _controller.getDashboardCards();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          'Inventory Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return _DashboardCard(card: cards[index]);
          },
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final DashboardCardModel card;

  const _DashboardCard({required this.card});

  IconData _getIcon(String key) {
    switch (key) {
      case 'approval':
        return Icons.fact_check_rounded;
      case 'grn':
        return Icons.receipt_long_rounded;
      case 'project':
        return Icons.apartment_rounded;
      case 'history':
        return Icons.history_rounded;
      default:
        return Icons.dashboard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),

      /// ✅ NAVIGATION
      onTap: () {
        Navigator.pushNamed(context, card.route);
      },

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIcon(card.icon),
                size: 20,
                color: const Color(0xFF2563EB),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.count.toString(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  card.title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
