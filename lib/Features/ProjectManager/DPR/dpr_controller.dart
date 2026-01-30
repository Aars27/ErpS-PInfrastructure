import 'package:dio/dio.dart';

import 'DprModule.dart';
import 'DprServiesss.dart';



class DPRController {
  final DPRApiService _service = DPRApiService();

  Future<void> createDPR(DPRModel dpr) async {
    try {
      final Response response = await _service.createDPR(dpr.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw response.data['message'] ?? 'Failed to create DPR';
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to create DPR';
    }
  }
}