import 'package:flutter/material.dart';
import 'package:smp_erp/Features/InventoryMangaers/StockScreen/stockmodal.dart';


class StockController extends ChangeNotifier {
  bool isLoading = true;
  List<StockModel> stocks = [];

  /// TEMP: API response se data load
  Future<void> loadStock(List<dynamic> apiData) async {
    isLoading = true;
    notifyListeners();

    stocks = apiData.map((e) => StockModel.fromJson(e)).toList();

    isLoading = false;
    notifyListeners();
  }

  Color getStatusColor(StockModel stock) {
    if (stock.currentStock <= stock.minimumThreshold) {
      return Colors.red;
    }
    return Colors.green;
  }
}
