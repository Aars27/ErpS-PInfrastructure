import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dpr_controller.dart';



class DprDetailScreen extends StatefulWidget {
  final int dprId;

  const DprDetailScreen({super.key, required this.dprId});

  @override
  State<DprDetailScreen> createState() => _DprDetailScreenState();
}

class _DprDetailScreenState extends State<DprDetailScreen> {
  final DPRController _controller = DPRController();
  Map<String, dynamic>? dprData;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchDPRDetails();
  }

  Future<void> _fetchDPRDetails() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final data = await _controller.getDPRDetails(widget.dprId);
      setState(() {
        dprData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'DPR Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF4F6FA),
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
              onPressed: _fetchDPRDetails,
              child: Text('Retry'),
            ),
          ],
        ),
      )
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (dprData!['project'] != null)
            _sectionCard(
              title: 'Project Information',
              children: [
                _infoRow('Project',
                    dprData!['project']['project_name'] ?? 'N/A'),
                _infoRow('Code',
                    dprData!['project']['project_code'] ?? 'N/A'),
                _infoRow('Type',
                    dprData!['project']['project_type'] ?? 'N/A'),
                _infoRow('Status',
                    dprData!['project']['status'] ?? 'N/A'),
                if (dprData!['project']['client'] != null)
                  _infoRow(
                      'Client', dprData!['project']['client']),
              ],
            ),
          _sectionCard(
            title: 'DPR Summary',
            children: [
              _infoRow('Date', _formatDate(dprData!['date'])),
              _infoRow('Weather',
                  dprData!['weather_conditions'] ?? 'N/A'),
              if (dprData!['Dimension'] != null)
                _infoRow('Dimension', dprData!['Dimension']),
              _infoRow('Safety',
                  dprData!['safety_incidents'] ?? 'N/A'),
              _infoRow('Remarks', dprData!['remarks'] ?? 'N/A'),
            ],
          ),
          if (dprData!['user'] != null)
            _sectionCard(
              title: 'Submitted By',
              children: [
                _infoRow('Name', dprData!['user']['name'] ?? 'N/A'),
                if (dprData!['user']['email'] != null)
                  _infoRow('Email', dprData!['user']['email']),
              ],
            ),
          _sectionCard(
            title: 'Cost Summary',
            children: [
              _infoRow('Material Cost',
                  '₹${dprData!['material_cost'] ?? 0}'),
              _infoRow('Labour Cost',
                  '₹${dprData!['labour_cost'] ?? 0}'),
              _infoRow('Machinery Cost',
                  '₹${dprData!['machinery_cost'] ?? 0}'),
              _infoRow(
                'Total Cost',
                '₹${dprData!['total_cost'] ?? 0}',
                bold: true,
              ),
            ],
          ),
          if (dprData!['machinery'] != null &&
              (dprData!['machinery'] as List).isNotEmpty)
            _sectionCard(
              title: 'Machinery Used',
              children: (dprData!['machinery'] as List)
                  .map<Widget>((m) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(m['machine_name'] ?? 'N/A'),
                  subtitle: Text(
                    'Code: ${m['machine_code'] ?? 'N/A'} | Hours: ${m['working_hours'] ?? 0}',
                  ),
                  trailing: Text(m['fuel_amount'] ?? '₹0'),
                );
              }).toList(),
            ),
          if (dprData!['labour_consumptions'] != null &&
              (dprData!['labour_consumptions'] as List).isNotEmpty)
            _sectionCard(
              title: 'Labour Details',
              children:
              (dprData!['labour_consumptions'] as List)
                  .map<Widget>((l) {
                if (l['labours'] != null &&
                    (l['labours'] as List).isNotEmpty) {
                  final labour =
                  l['labours'][0]['labour'];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                        labour['labour_name'] ?? 'N/A'),
                    subtitle: Text(
                      '${labour['skill'] ?? 'N/A'} | ${labour['phone_number'] ?? 'N/A'}',
                    ),
                    trailing: Text('₹${l['charges'] ?? 0}'),
                  );
                }
                return SizedBox.shrink();
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}