import 'package:flutter/material.dart';
import 'package:smp_erp/Features/mainInventorymanagement/StockCreate/StockModal.dart';
import 'package:smp_erp/Features/mainInventorymanagement/StockCreate/Stock_Services.dart';




class StockController extends ChangeNotifier {
  final StockService _service = StockService();

  bool isLoading = false;

  Future<void> createStock(StockModel stock) async {
    isLoading = true;
    notifyListeners();

    try {
      await _service.createStock(stock.toJson());
    } catch (e) {
      debugPrint('❌ STOCK CREATE ERROR: $e');
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
