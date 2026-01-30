import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smp_erp/Features/InventoryMangaers/ShowingPrMaterial/prmodal.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';
import '../../../Core/Storage/local_storage.dart';




class PRshowingController extends ChangeNotifier {
  bool isLoading = false;
  List<PRModel> prs = [];

  Future<void> fetchPRs() async {
    try {
      isLoading = true;
      notifyListeners();

      final api = ApiService();
      final res = await api.get(ApiConstants.pr);

      prs = (res.data['data'] as List)
          .map((e) => PRModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('❌ PR FETCH ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitPR(int id) async {
    try {
      final token = await LocalStorage.getToken();
      final api = ApiService();

      final body = {
        "status": "SUBMITTED",
        "send_to": 3,
        "remarks": "Ready for inventory check",
      };

      final res = await api.post(
        ApiConstants.submitPr(id),
        body,
        headers: ApiConstants.inventoryHeaders(token!),
      );

      debugPrint(' PR SUBMITTED');
      debugPrint(res.data.toString());

      fetchPRs(); // refresh list

    } on DioException catch (e) {
      debugPrint('❌ SUBMIT PR ERROR');
      debugPrint(e.response?.data.toString());
    }
  }

}
