import 'package:flutter/material.dart';
import 'package:smp_erp/Features/InventoryDashoboardddddd/Inventory_dashboard_scsreen.dart';

import '../../Features/InventoryDashoboardddddd/InventorymoduleManagerinventory/InventoryHistoryyscereer.dart';
import '../../Features/InventoryDashoboardddddd/InventorymoduleManagerinventory/project_list_screennnn.dart';
import '../../Features/InventoryDashoboardddddd/InventorymoduleManagerinventory/projeeect_detailsss_screeen.dart';
import '../../Features/InventoryDashoboardddddd/Inventoryscreenim/GrnScreen/Grn_Scdreate_screen.dart';
import '../../Features/InventoryDashoboardddddd/Inventoryscreenim/PrApprovalLIst.dart';
import '../../Features/SplashScreen/SplashScreen.dart';
import '../../Features/LoginScreen/LoginScreen.dart';
import '../../Core/BottomPage/MainWrapperScreen.dart';



import '../../Features/allscreens/dpr modules.dart';
import '../../Features/allscreens/projectmanagement.dart';
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

    /// ---------------- INVENTORY MANAGER ----------------
      case AppRoutes.inventoryHome:
        return MaterialPageRoute(
          builder: (_) => InventoryDashboardScreen(),
        );

      // case AppRoutes.prApproval:
      //   return MaterialPageRoute(
      //     builder: (_) => PRDetailScreen(),
      //   );

      case AppRoutes.grnCreate:
        return MaterialPageRoute(
          builder: (_) => const GRNCreateScreen(),
        );

    /// ---------------- PROJECT ----------------
      case AppRoutes.projectList:
        return MaterialPageRoute(
          builder: (_) => ProjectListScreen(),
        );

      case AppRoutes.projectDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProjectDetailScreen(
            project: args['project'],
          ),
        );

    /// ---------------- DPR ----------------
      case AppRoutes.dprCreate:
        return MaterialPageRoute(
          builder: (_) => CreateDPRScreen(projectId: 1, userId:1 ,),
        );


        // enventory


      case '/pr-approval':
        return MaterialPageRoute(builder: (_) =>  PRApprovalListScreen());

      case '/grn':
        return MaterialPageRoute(builder: (_) => const GRNCreateScreen());

      case '/projects':
        return MaterialPageRoute(builder: (_) =>  ProjectListScreen());

      case '/inventory-history':
        return MaterialPageRoute(builder: (_) => InventoryHistoryScreen());











      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );













    }






  }
}
