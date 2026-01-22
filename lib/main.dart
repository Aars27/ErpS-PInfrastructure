import 'package:flutter/material.dart';
import 'package:smp_erp/Activities/AddMaterialRequestScreen.dart';
import 'package:smp_erp/Activities/AddStockScreen.dart';
import 'package:smp_erp/Activities/HomeScreen.dart';
import 'package:smp_erp/Activities/LoginScreen.dart';
import 'package:smp_erp/Activities/MaterialRequestsScreen.dart';
import 'package:smp_erp/Activities/InventoryScreen.dart';
import 'package:smp_erp/Activities/SettingsScreen.dart';
import 'package:smp_erp/Activities/StockScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMP ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF6B35)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
        '/stock': (context) => const StockScreen(),
        '/MaterialRequestsScreen': (context) => const MaterialRequestsScreen(),
        '/Inventory Management': (context) => const Inventoryscreen(),
        '/settings': (context) => const SettingsScreen(),
        '/AddStockScreen': (context) => const AddStockScreen(),
        '/AddMaterialRequestScreen': (context) => const AddMaterialRequestScreen(),
      },
    );
  }
}