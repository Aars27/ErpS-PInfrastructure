import 'package:flutter/material.dart';

import '../../Core/Router/AppRoutes.dart';
import '../../Core/Storage/local_storage.dart';
import '../DashboardScreen/HomeScreen.dart';




class SplashHandler {
  static Future<void> handle(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)); // splash visible

    final token = await LocalStorage.getToken();

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }
}
