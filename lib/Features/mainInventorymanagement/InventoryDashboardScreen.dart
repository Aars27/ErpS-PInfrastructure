import 'package:flutter/material.dart';

import '../../Core/Router/AppRoutes.dart';

class InventoryDashboardScreen extends StatelessWidget {
  const InventoryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _box(
              context,
              title: 'Stock & PR',
              icon: Icons.inventory_2,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.stockCreate);
              },
            ),
            _box(
              context,
              title: 'GRN',
              icon: Icons.receipt_long,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.grnCreate);
              },
            ),
            _box(
              context,
              title: 'Materials',
              icon: Icons.category,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.materials);
              },
            ),
            _box(
              context,
              title: 'Category',
              icon: Icons.list_alt,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.materialCategory);
              },
            ),
            _box(
              context,
              title: 'Unit',
              icon: Icons.straighten,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.materialUnit);
              },
            ),
            _box(
              context,
              title: 'Creare PR',
              icon: Icons.work,
              onTap: () {

                // Navigator.pushNamed(context, AppRoutes.materialUnit);

                },
            ),


          ],
        ),
      ),
    );
  }

  Widget _box(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: const Color(0xFFFF6B35)),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
