import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smp_erp/Features/mainInventorymanagement/StockCreate/Stock_controller.dart';
import '../../Features/InventoryMangaers/Inventory_controller.dart';
import '../../Features/InventoryMangaers/ShowingPrMaterial/ShowingprController.dart';
import '../../Features/ProfileScreen/profileController.dart';
import '../../Features/ProjectManager/ChainageTraking/chainageModal.dart';
import '../../Features/ProjectManager/PrGenrate/PrController.dart';
import '../../Features/ProjectManager/Project_Controller.dart';
import '../../Features/SplashScreen/SplashContoller.dart';
import '../../Features/mainInventorymanagement/Category/Categorycontroller.dart';
import '../../Features/mainInventorymanagement/Unit/unitController.dart';
import '../../Features/mainInventorymanagement/grn/grn_Controller.dart';
import '../../Features/mainInventorymanagement/materailcreateeeee/Material_controller.dart';
import '../Router/AppRoutes.dart';
import '../Router/Router.dart';



class MainProviders extends StatelessWidget {
  const MainProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SplashController()),
          ChangeNotifierProvider(create: (_) => ProfileController()),
          ChangeNotifierProvider(create: (_) => ProjectController()),
          ChangeNotifierProvider(create: (_) => ChainageController()),
          ChangeNotifierProvider(create: (_) => InventoryController()),
          ChangeNotifierProvider(create: (_) => PRshowingController()),
          ChangeNotifierProvider(create: (_) => CategoryController()),
          ChangeNotifierProvider(create: (_) => UnitController()),
          ChangeNotifierProvider(create: (_) => MaterialController()),
          ChangeNotifierProvider(create: (_) => GRNController()),
          ChangeNotifierProvider(create: (_) => StockController()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      );



  }
}
