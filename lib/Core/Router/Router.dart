import 'package:flutter/material.dart';
import 'package:smp_erp/Features/mainInventorymanagement/StockCreate/StcokScreen.dart';

import '../../Features/SplashScreen/SplashScreen.dart';
import '../../Features/LoginScreen/LoginScreen.dart';
import '../../Core/BottomPage/MainWrapperScreen.dart';



import '../../Features/ProjectManager/DPR/CreateDpRScreen.dart';
import '../../Features/mainInventorymanagement/Category/CategoryScreen.dart';
import '../../Features/mainInventorymanagement/InventoryDashboardScreen.dart';
import '../../Features/mainInventorymanagement/Unit/screenunit.dart';
import '../../Features/mainInventorymanagement/grn/grnCreateScsren.dart';
import '../../Features/mainInventorymanagement/materailcreateeeee/Material_Screen.dart';
import 'AppRoutes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

    /// ---------------- CORE ----------------
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => MainWrapperScreen());

    /// ---------------- INVENTORY ----------------
      case AppRoutes.inventoryHome:
        return MaterialPageRoute(
          builder: (_) => const InventoryDashboardScreen(),
        );

      case AppRoutes.materials:
        return MaterialPageRoute(
          builder: (_) => const MaterialScreen(),
        );

      case AppRoutes.materialCategory:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(),
        );

      case AppRoutes.materialUnit:
        return MaterialPageRoute(
          builder: (_) => const UnitScreen(),
        );

    /// ---------------- DPR ----------------
      case AppRoutes.dprCreate:
        return MaterialPageRoute(
          builder: (_) => CreateDPRScreen(projectId: 1),
        );



        // grn
      case AppRoutes.grnCreate:
        return MaterialPageRoute(
          builder: (_) => GRNCreateScreen(),
        );


    // grn
      case AppRoutes.stockCreate:
        return MaterialPageRoute(
          builder: (_) =>StockCreateScreen(),
        );


    /// ---------------- FALLBACK ----------------
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}
