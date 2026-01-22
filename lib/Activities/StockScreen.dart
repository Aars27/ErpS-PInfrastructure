import 'package:flutter/material.dart';
import 'package:smp_erp/Activities/AddStockScreen.dart';
import 'package:smp_erp/Navigations/NavigationHelper.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stock Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              'Track and manage inventory',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.grey[700],
                      size: 22,
                    ),
                    onPressed: () {
                      _showFilterDialog();
                    },
                  ),
                ),
              ],
            ),
          ),

          // Stock Items List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildStockCard(
                  title: 'Portland Cement',
                  subtitle: 'Crust • Highway Project A',
                  quantity: '450 Bags',
                  status: 'In Stock',
                  statusColor: Colors.green,
                ),
                const SizedBox(height: 12),
                _buildStockCard(
                  title: 'Steel Rods 12mm',
                  subtitle: 'Structure • Bridge Project B',
                  quantity: '85 Pieces',
                  status: 'Low Stock',
                  statusColor: Colors.red,
                  isReorder: true,
                ),
                const SizedBox(height: 12),
                _buildStockCard(
                  title: 'Aggregates',
                  subtitle: 'Earthwork • Building Project C',
                  quantity: '250 Ton',
                  status: 'In Stock',
                  statusColor: Colors.green,
                ),
                const SizedBox(height: 12),
                _buildStockCard(
                  title: 'Safety Cones',
                  subtitle: 'Misc • Tunnel Project D',
                  quantity: '30 Pieces',
                  status: 'In Stock',
                  statusColor: Colors.green,
                ),
                const SizedBox(height: 80), // Extra space for FAB
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      //    _showAddStockDialog();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStockScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFFFF6B35),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: NavigationHelper.buildBottomNavBar(context, 1),
    );
  }

  Widget _buildStockCard({
    required String title,
    required String subtitle,
    required String quantity,
    required String status,
    required Color statusColor,
    bool isReorder = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quantity,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Available Quantity',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              if (isReorder)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Reorder',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }



  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Items'),
              leading: Radio(value: 0, groupValue: 0, onChanged: (val) {}),
            ),
            ListTile(
              title: const Text('In Stock'),
              leading: Radio(value: 1, groupValue: 0, onChanged: (val) {}),
            ),
            ListTile(
              title: const Text('Low Stock'),
              leading: Radio(value: 2, groupValue: 0, onChanged: (val) {}),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}