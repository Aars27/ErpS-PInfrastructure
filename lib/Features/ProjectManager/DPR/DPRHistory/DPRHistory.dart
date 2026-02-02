import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dpr_controller.dart';
import 'DPRDetailsScreen.dart';
import 'DprModal.dart';




class DPRHistoryScreen extends StatefulWidget {
  final int? projectId;

  const DPRHistoryScreen({super.key, this.projectId});

  @override
  State<DPRHistoryScreen> createState() => _DPRHistoryScreenState();
}

class _DPRHistoryScreenState extends State<DPRHistoryScreen> {
  final DPRController _controller = DPRController();
  List<DPRListItem> dprs = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchDPRs();
  }

  Future<void> _fetchDPRs() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final fetchedDPRs = await _controller.getDPRs();

      setState(() {
        dprs = fetchedDPRs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text('DPR History', style: TextStyle(fontSize: 16)),
        backgroundColor: Color(0xFFF15716),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchDPRs,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text('Error: $error'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchDPRs,
              child: Text('Retry'),
            ),
          ],
        ),
      )
          : dprs.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined,
                size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No DPRs found',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: _fetchDPRs,
        child: ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: dprs.length,
          itemBuilder: (context, index) {
            final dpr = dprs[index];
            return _buildDPRCard(dpr);
          },
        ),
      ),
    );
  }

  Widget _buildDPRCard(DPRListItem dpr) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DprDetailScreen(dprId: dpr.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFF15716).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'DPR #${dpr.id}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF15716),
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    _formatDate(dpr.date),
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Weather & Safety
              Row(
                children: [
                  Icon(Icons.wb_sunny, size: 14, color: Colors.orange),
                  SizedBox(width: 4),
                  Text(dpr.weatherConditions,
                      style: TextStyle(fontSize: 11)),
                  SizedBox(width: 16),
                  Icon(Icons.security, size: 14, color: Colors.green),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      dpr.safetyIncidents,
                      style: TextStyle(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              if (dpr.remarks.isNotEmpty) ...[
                SizedBox(height: 8),
                Text(
                  dpr.remarks,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              SizedBox(height: 10),
              Divider(height: 1),
              SizedBox(height: 10),

              // Stats Row
              Row(
                children: [
                  _buildStat(Icons.construction, '${dpr.materialsCount}',
                      'Materials'),
                  _buildStat(Icons.people, '${dpr.laboursCount}', 'Labour'),
                  _buildStat(
                      Icons.precision_manufacturing, '${dpr.machineryCount}', 'Machinery'),
                  if (dpr.filesCount > 0)
                    _buildStat(Icons.attach_file, '${dpr.filesCount}', 'Files'),
                ],
              ),

              SizedBox(height: 10),
              Divider(height: 1),
              SizedBox(height: 10),

              // Cost Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Cost',
                      style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(
                    '₹${dpr.totalCost.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Color(0xFFF15716)),
          SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              Text(label, style: TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}