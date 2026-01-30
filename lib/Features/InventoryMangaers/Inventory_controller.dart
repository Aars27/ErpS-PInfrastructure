import 'package:flutter/material.dart';
import '../../Constants/ApiConstants.dart';
import '../../Constants/ApiService.dart';
import 'StockScreen/stockmodal.dart';
import 'inventory_models.dart';

class InventoryController extends ChangeNotifier {
  bool isLoading = false;

  InventoryUserModel? user;
  InventoryLocationModel? location;
  List<StockModel> stocks = [];

  Future<void> fetchInventory() async {
    try {
      isLoading = true;
      notifyListeners();

      final api = ApiService();
      final res = await api.get(ApiConstants.inventoryManager);

      final List list = res.data['data'];

      /// 🔥 CURRENT USER INVENTORY (TEMP: FIRST INDEX)
      final item = list.first;

      user = InventoryUserModel.fromJson(item['user']);
      location = InventoryLocationModel.fromJson(item['location']);

      stocks = (item['assigned_stocks'] as List)
          .map((e) => StockModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('❌ INVENTORY ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
