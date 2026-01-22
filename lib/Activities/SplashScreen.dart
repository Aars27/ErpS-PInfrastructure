import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smp_erp/Activities/LoginScreen.dart';
import 'package:smp_erp/Permissions/PermissionService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PermissionService _permissionService = PermissionService();
  bool _isCheckingPermissions = true;
  String _statusMessage = 'Checking permissions...';

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermissions();
  }

  Future<void> _checkAndRequestPermissions() async {
    await Future.delayed(const Duration(seconds: 2));

    // Check if all permissions are granted
    bool allGranted = await _permissionService.checkAllPermissions();

    if (allGranted) {
      _navigateToLogin();
    } else {
      setState(() {
        _isCheckingPermissions = false;
        _statusMessage = 'Permissions Required';
      });
    }
  }

  Future<void> _requestPermissions() async {
    setState(() {
      _statusMessage = 'Requesting permissions...';
    });

    final results = await _permissionService.requestAllPermissions();

    // Check if any permission was permanently denied
    bool permanentlyDenied = results.values.any((status) => status.isPermanentlyDenied);

    if (permanentlyDenied) {
      _showSettingsDialog();
    } else {
      bool allGranted = await _permissionService.checkAllPermissions();
      if (allGranted) {
        _navigateToLogin();
      } else {
        setState(() {
          _statusMessage = 'Some permissions denied';
        });
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'Some permissions are permanently denied. Please enable them from app settings to continue.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _permissionService.openSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Needed'),
          content: const Text(
            'All permissions are required to use this app. Please grant them to continue.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _requestPermissions();
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF6B1A), // Orange
              Color(0xFFFF8534), // Lighter orange
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // S&P Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    'S&P',
                    style: TextStyle(
                      color: Color(0xFFFF6B1A),
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ERP Suite Title
              const Text(
                'ERP Suite',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Construction Management System',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 60),

              // Loading or Permission UI
              if (_isCheckingPermissions)
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                )
              else
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'We need the following permissions to continue:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPermissionItem(Icons.location_on, 'Location'),
                    _buildPermissionItem(Icons.camera_alt, 'Camera'),
                    _buildPermissionItem(Icons.photo_library, 'Gallery'),
                    _buildPermissionItem(Icons.notifications, 'Notifications'),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _requestPermissions,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFFF6B1A),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Grant Permissions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Text(
                _statusMessage,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}