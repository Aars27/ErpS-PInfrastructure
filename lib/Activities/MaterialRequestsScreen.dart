import 'package:flutter/material.dart';
import 'package:smp_erp/Activities/AddMaterialRequestScreen.dart';
import 'package:smp_erp/Navigations/NavigationHelper.dart';

class MaterialRequestsScreen extends StatefulWidget {
  const MaterialRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MaterialRequestsScreen> createState() => _MaterialRequestsScreenState();
}

class _MaterialRequestsScreenState extends State<MaterialRequestsScreen> {
  String selectedTab = 'all';

  final List<MaterialRequest> allRequests = [
    MaterialRequest(
      material: 'Portland Cement',
      priority: 'High',
      quantity: '200 Bags • Crust',
      project: 'Highway Project A',
      purpose: 'Foundation work Phase 2',
      requested: 'Nov 25, 2025',
      status: 'Pending',
    ),
    MaterialRequest(
      material: 'Steel Rods 12mm',
      priority: 'Medium',
      quantity: '150 Pieces • Structure',
      project: 'Bridge Project B',
      purpose: 'Bridge reinforcement',
      requested: 'Nov 24, 2025',
      status: 'Approved',
    ),
    MaterialRequest(
      material: 'Concrete Mix',
      priority: 'High',
      quantity: '5 Ton • Earthwork',
      project: 'Tunnel Project D',
      purpose: 'Tunnel lining work',
      requested: 'Nov 26, 2025',
      status: 'Pending',
    ),
    MaterialRequest(
      material: 'Safety Helmets',
      priority: 'Low',
      quantity: '50 Pieces • Misc',
      project: 'Building Project C',
      purpose: 'New worker safety equipment',
      requested: 'Nov 23, 2025',
      status: 'Rejected',
    ),
  ];

  List<MaterialRequest> get filteredRequests {
    if (selectedTab == 'all') return allRequests;
    return allRequests
        .where((req) => req.status.toLowerCase() == selectedTab)
        .toList();
  }

  int getCount(String status) {
    if (status == 'all') return allRequests.length;
    return allRequests.where((req) => req.status.toLowerCase() == status).length;
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.access_time;
      case 'Approved':
        return Icons.check_circle;
      case 'Rejected':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Material Requests',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Manage stock out requests',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[300],
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          // Tab Bar with Horizontal Scroll
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab('All', 'all', getCount('all')),
                  const SizedBox(width: 8),
                  _buildTab('Pending', 'pending', getCount('pending')),
                  const SizedBox(width: 8),
                  _buildTab('Approved', 'approved', getCount('approved')),
                  const SizedBox(width: 8),
                  _buildTab('Rejected', 'rejected', getCount('rejected')),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            height: 1,
          ),

          // Request Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredRequests.length,
              itemBuilder: (context, index) {
                return _buildRequestCard(filteredRequests[index]);
              },
            ),
          ),
        ],
      ),

      // FAB Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Material Request Screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMaterialRequestScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFFFF6B35),
        child: const Icon(Icons.add, size: 28),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: NavigationHelper.buildBottomNavBar(context, 2),
    );
  }


  Widget _buildTab(String label, String value, int count) {
    bool isSelected = selectedTab == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B35) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B35) : Colors.grey[300]!,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Text(
          '$label ($count)',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(MaterialRequest request) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          request.material,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: getPriorityColor(request.priority).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          request.priority,
                          style: TextStyle(
                            color: getPriorityColor(request.priority),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(request.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        getStatusIcon(request.status),
                        color: getStatusColor(request.status),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        request.status,
                        style: TextStyle(
                          color: getStatusColor(request.status),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              request.quantity,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Project: ${request.project}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Purpose: ${request.purpose}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Requested: ${request.requested}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),

            // Action Buttons (only for Pending status)
            if (request.status == 'Pending') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Approve'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Reject'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}


class MaterialRequest {
  final String material;
  final String priority;
  final String quantity;
  final String project;
  final String purpose;
  final String requested;
  final String status;

  MaterialRequest({
    required this.material,
    required this.priority,
    required this.quantity,
    required this.project,
    required this.purpose,
    required this.requested,
    required this.status,
  });
}