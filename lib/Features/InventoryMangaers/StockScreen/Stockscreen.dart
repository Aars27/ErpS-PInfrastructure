import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'StockController.dart';



class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    super.initState();

    /// TEMP DATA LOAD (tum yahan API response pass karoge)
    Future.microtask(() {
      context.read<StockController>().loadStock(sampleStockResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StockController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock'),
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.stocks.isEmpty
          ? const Center(child: Text('No stock available'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.stocks.length,
        itemBuilder: (context, index) {
          final stock = controller.stocks[index];
          return _stockCard(stock, controller);
        },
      ),
    );
  }

  Widget _stockCard(stock, StockController controller) {
    final isLow = stock.currentStock <= stock.minimumThreshold;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stock.materialName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: controller.getStatusColor(stock).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isLow ? 'LOW STOCK' : 'IN STOCK',
                    style: TextStyle(
                      color: controller.getStatusColor(stock),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              stock.materialCode,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const Divider(height: 24),

            _row('Category', stock.category),
            _row('Location', stock.location),
            _row(
              'Quantity',
              '${stock.currentStock} ${stock.unit}',
              valueColor: isLow ? Colors.red : Colors.black,
            ),
            _row(
              'Minimum Threshold',
              '${stock.minimumThreshold} ${stock.unit}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// TEMP SAMPLE DATA (tum API se replace karoge)
final sampleStockResponse = [
  {
    "id": 3,
    "status": "IN_STOCK",
    "minimum_threshold_quantity": 100,
    "current_stock": 500,
    "material": {
      "name": "Cement",
      "material_code": "MAT-CEMENT-001",
      "category": {"name": "Construction Materials"},
      "unit": {"name": "Bags"}
    },
    "location": {
      "village": "Andheri",
      "district": "Mumbai"
    }
  }
];
