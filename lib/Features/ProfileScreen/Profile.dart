import 'package:flutter/material.dart';

import '../InventoryDashoboardddddd/Inventory_dashboard_scsreen.dart';
import '../allscreens/dpr modules.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final Map<String, dynamic> profileJson = const {
    "status": 200,
    "user": {
      "id": 1,
      "name": "John Doe",
      "email": "john.doe@example.com",
      "mobileNumber": "+1234567890",
      "role": {
        "name": "Project Manager",
        "permissions": [
          {
            "action": ["create", "read", "update", "delete"],
            "modules": [
              // {
              //   "Name": "Dashboard",
              //   "description":
              //   "Centralized overview of system statistics, insights, and key metrics"
              // },
              {
                "Name": "Manage Role & Permission",
                "description":
                "Role and permission configuration and access control management module"
              },
              {
                "Name": "Project Management",
                "description":
                "Project planning, tracking, and execution management module"
              },
              {
                "Name": "Vendor Management",
                "description":
                "Vendor onboarding, tracking, and management module"
              },
              {
                "Name": "User Management",
                "description":
                "User account creation, update, and access management module"
              },
              {
                "Name": "Role Management",
                "description":
                "Role creation, permission assignment, and access control module"
              },
              {
                "Name": "Inventory Management",
                "description":
                "Inventory tracking, stock management, and item control module"
              },
              {
                "Name": "DPR Module",
                "description":
                "Daily Progress Report creation and monitoring module"
              },
              {
                "Name": "Master Creation",
                "description": "Master data configuration and setup module"
              },
              {
                "Name": "Chainage Tracking",
                "description":
                "Chainage-based progress and location tracking module"
              },
              {
                "Name": "Sub Contractor",
                "description": "Sub Contractor"
              }
            ]
          }
        ]
      }
    }
  };

  IconData _getModuleIcon(String moduleName) {
    switch (moduleName) {
      // case 'Dashboard':
      //   return Icons.dashboard_rounded;
      case 'Manage Role & Permission':
        return Icons.admin_panel_settings_rounded;
      case 'Project Management':
        return Icons.folder_rounded;
      case 'Vendor Management':
        return Icons.store_rounded;
      case 'User Management':
        return Icons.people_rounded;
      case 'Role Management':
        return Icons.security_rounded;
      case 'Inventory Management':
        return Icons.inventory_2_rounded;
      case 'DPR Module':
        return Icons.description_rounded;
      case 'Master Creation':
        return Icons.settings_rounded;
      case 'Chainage Tracking':
        return Icons.timeline_rounded;
      case 'Sub Contractor':
        return Icons.construction_rounded;
      default:
        return Icons.widgets_rounded;
    }
  }

  void _navigateToModule(BuildContext context, String moduleName) {
    if (moduleName == 'Inventory Management') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const DPRModuleScreen()),
      // );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InventoryDashboardScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = profileJson['user'];
    final role = user['role'];
    final permissions = role['permissions'][0];
    final modules = permissions['modules'];
    final actions = permissions['action'];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5EE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent
        ),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF6B35),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// USER CARD
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(0xFFFF6B35),
                  child: Icon(Icons.person, color: Colors.white, size: 34),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user['email'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '🔑 ${role['name']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Modules & Permissions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// MODULE GRID
          ...modules.map<Widget>((module) {
            return InkWell(
              onTap: () => _navigateToModule(context, module['Name']),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFFF6B35).withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6B35).withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getModuleIcon(module['Name']),
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            module['Name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Color(0xFFFF6B35),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      module['description'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: actions
                          .map<Widget>(
                            (a) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B35).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFFF6B35).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            a.toString().toUpperCase(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFF6B35),
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Module Detail Screen
class ModuleDetailScreen extends StatelessWidget {
  final String moduleName;

  const ModuleDetailScreen({super.key, required this.moduleName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          moduleName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF6B35),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              moduleName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Module page loaded successfully!\nYou can add your content here.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}