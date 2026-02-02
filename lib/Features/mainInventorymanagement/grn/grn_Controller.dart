import 'package:flutter/material.dart';
import 'package:smp_erp/Features/mainInventorymanagement/grn/grnmodal.dart';
import '../../../Constants/ApiService.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Core/Storage/local_storage.dart';

class GRNController extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;
  List<GRN> grns = [];

  /// ---------------- CREATE GRN ----------------
  Future<void> createGRN({
    required int poId,
    required List<int> fileIds,
    required List<Map<String, dynamic>> materials,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await LocalStorage.getToken();

      await _api.post(
        ApiConstants.grn,
        {
          "po_id": poId,
          "gate_entry_number": "GE-2024-001",
          "vehicle_number": "MH-01-AB-1234",
          "driver_name": "Rajesh Kumar",
          "driver_contact": "+91-9876543210",
          "transport_mode": "ROAD",
          "status": "RECEIVED",
          "received_date": DateTime.now().toIso8601String(),
          "received_time": "10:30",
          "store_location": "Warehouse A",
          "quality_check_completed": false,
          "grn_remarks": "Received as per schedule",
          "file_ids": fileIds,
          "material_receipts": materials,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'x-module': 'Inventory Management',
          'action-perform': 'create',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
    } catch (e) {
      debugPrint('❌ CREATE GRN ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }





  /// ---------------- HISTORY ----------------

  Future<void> fetchGRNHistory() async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await _api.get(ApiConstants.grn);

      final List list =
          res.data['grns'] ?? res.data['data'] ?? [];

      grns = list.map((e) => GRN.fromJson(e)).toList();
    } catch (e) {
      debugPrint('❌ FETCH GRN ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }







}
