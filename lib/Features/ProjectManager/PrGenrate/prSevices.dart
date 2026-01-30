import 'package:dio/dio.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';

class PRApiService {
  final ApiService _apiService = ApiService(type: ApiType.app);

  /// CREATE PURCHASE REQUISITION
  Future<Response> createPR(Map<String, dynamic> payload) async {
    return await _apiService.post(
      ApiConstants.pr,
      payload,
      headers: {
        'x-module': 'Inventory Management',
        'action-perform': 'create',
      },
    );
  }
}
