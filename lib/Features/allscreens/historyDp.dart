import 'package:flutter/material.dart';

class DprDetailScreen extends StatelessWidget {
  const DprDetailScreen({super.key});

  // 🔥 EXACT JSON YOU SENT
  final Map<String, dynamic> dprJson = const {
    "status": 200,
    "data": {
      "id": 6,
      "date": "2024-01-15T10:30:00.000Z",
      "weather_conditions": "Sunny",
      "safety_incidents": "No incidents",
      "remarks": "Work completed as planned",
      "material_cost": 50000,
      "labour_cost": 20000,
      "machinery_cost": 30000,
      "total_cost": 100000,
      "project": {
        "project_name": "Highway Construction Project",
        "project_code": "PROJ-HWY-2024-001",
        "project_type": "HAM",
        "status": "PLANNED",
        "client": "National Highways Authority"
      },
      "user": {
        "name": "John Doe",
        "email": "john.doe@example.com"
      },
      "machinery": [
        {
          "machine_name": "Excavator",
          "machine_code": "EXC-001",
          "working_hours": 8,
          "fuel_type": "Diesel",
          "fuel_consumed": "50 Liters",
          "fuel_amount": "₹5000"
        }
      ],
      "labour_consumptions": [
        {
          "skill": "Mason",
          "hours": 8,
          "charges": 500,
          "labours": [
            {
              "labour": {
                "labour_name": "Rahul Sharma",
                "labour_code": "LAB-001",
                "skill": "Electrician",
                "phone_number": "+91 9876543210"
              }
            }
          ]
        }
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    final data = dprJson['data'];
    final project = data['project'];
    final user = data['user'];
    final machinery = data['machinery'] as List;
    final labours = data['labour_consumptions'] as List;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
iconTheme: IconThemeData(
  color: Colors.white
),
        title: const Text('DPR Details',

          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
      ),
      backgroundColor: const Color(0xFFF4F6FA),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionCard(
            title: 'Project Information',
            children: [
              _infoRow('Project', project['project_name']),
              _infoRow('Code', project['project_code']),
              _infoRow('Type', project['project_type']),
              _infoRow('Status', project['status']),
              _infoRow('Client', project['client']),
            ],
          ),

          _sectionCard(
            title: 'DPR Summary',
            children: [
              _infoRow('Date', data['date']),
              _infoRow('Weather', data['weather_conditions']),
              _infoRow('Safety', data['safety_incidents']),
              _infoRow('Remarks', data['remarks']),
            ],
          ),

          _sectionCard(
            title: 'Submitted By',
            children: [
              _infoRow('Name', user['name']),
              _infoRow('Email', user['email']),
            ],
          ),

          _sectionCard(
            title: 'Cost Summary',
            children: [
              _infoRow('Material Cost', '₹${data['material_cost']}'),
              _infoRow('Labour Cost', '₹${data['labour_cost']}'),
              _infoRow('Machinery Cost', '₹${data['machinery_cost']}'),
              _infoRow(
                'Total Cost',
                '₹${data['total_cost']}',
                bold: true,
              ),
            ],
          ),

          _sectionCard(
            title: 'Machinery Used',
            children: machinery.map<Widget>((m) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(m['machine_name']),
                subtitle: Text(
                  'Code: ${m['machine_code']} | Hours: ${m['working_hours']}',
                ),
                trailing: Text(m['fuel_amount']),
              );
            }).toList(),
          ),

          _sectionCard(
            title: 'Labour Details',
            children: labours.map<Widget>((l) {
              final labour = l['labours'][0]['labour'];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(labour['labour_name']),
                subtitle: Text(
                  '${labour['skill']} | ${labour['phone_number']}',
                ),
                trailing: Text('₹${l['charges']}'),
              );
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
