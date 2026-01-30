import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smp_erp/Core/Storage/local_storage.dart';
import '../../Core/Permission/Permission_service.dart';
import '../../Core/Router/AppRoutes.dart';
import '../DashboardScreen/HomeScreen.dart';





class SplashController extends ChangeNotifier {
  final PermissionService _permissionService = PermissionService();

  bool isCheckingPermissions = true;
  String statusMessage = 'Initializing application...';

  Future<void> start(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final granted = await _permissionService.checkAllPermissions();

      if (!granted) {
        final result = await _permissionService.requestAllPermissions();

        final permanentlyDenied =
        result.values.any((s) => s.isPermanentlyDenied);

        /// 🔑 Never block app
        if (permanentlyDenied) {
          _goNext(context);
          return;
        }
      }

      _goNext(context);
    } catch (_) {
      _goNext(context);
    }
  }

  void _goNext(BuildContext context) async {
    final token = await LocalStorage.getToken();

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  Future<void> requestPermissions(BuildContext context) async {
    await _permissionService.requestAllPermissions();
    _goNext(context);
  }
}
