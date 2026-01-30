import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smp_erp/Features/ProjectManager/PrGenrate/Modal.dart';
import 'package:smp_erp/Features/ProjectManager/PrGenrate/prSevices.dart';





class PRController {
  final PRApiService _apiService = PRApiService();

  Future<Map<String, dynamic>> submitPR(PurchaseRequisition pr) async {
    try {
      final response = await _apiService.createPR(pr.toJson());
      return response.data;
    } on DioException catch (e) {
      /// 🔴 PRINT FULL BACKEND ERROR
      debugPrint('BACKEND ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('BACKEND ERROR DATA: ${e.response?.data}');

      /// ✅ THROW EXACT BACKEND MESSAGE
      if (e.response?.data is Map &&
          e.response?.data['message'] != null) {
        throw e.response!.data['message'];
      }

      throw 'Server error (${e.response?.statusCode})';
    }
  }
}
