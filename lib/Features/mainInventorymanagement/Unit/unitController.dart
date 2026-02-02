import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';
import '../../../Core/Storage/local_storage.dart';
import 'UnitModal.dart';



class UnitController extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;
  List<UnitModel> units = [];

  /// GET UNIT HISTORY
  Future<void> fetchUnits() async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await _api.get(ApiConstants.unit);
      final List list = res.data['units'];

      units = list.map((e) => UnitModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('❌ FETCH UNIT ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ADD UNIT
  Future<String?> addUnit({
    required String name,
    required String description,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await LocalStorage.getToken();

      final res = await _api.post(
        ApiConstants.unit,
        {
          "name": name.trim(),
          "description": description.trim(),
        },
        headers: {
          'Authorization': 'Bearer $token',
          'x-module': 'Inventory Management',
          'action-perform': 'create',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        await fetchUnits();
        return "Unit added successfully";
      }
    } on DioException catch (e) {
      debugPrint("❌ STATUS: ${e.response?.statusCode}");
      debugPrint("❌ DATA: ${e.response?.data}");
      return e.response?.data['message'] ?? "Failed to add unit";
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }





}
