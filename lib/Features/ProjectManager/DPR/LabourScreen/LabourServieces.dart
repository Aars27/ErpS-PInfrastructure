import 'package:dio/dio.dart';
import '../../../../Constants/ApiConstants.dart';
import '../../../../Constants/ApiService.dart';

class LabourApiService {
  final ApiService _api = ApiService(type: ApiType.app);

  Future<Response> getLabours({int page = 1, int limit = 100}) async {
    try {
      print('👷 Calling Labour API: ${ApiConstants.labour}');

      final response = await _api.get(
        ApiConstants.labour,
        headers: {
          'x-module': 'Labour Management',
        },
      );

      print('✅ Labour API Status: ${response.statusCode}');
      print('✅ Labour API Data Type: ${response.data.runtimeType}');

      return response;

    } on DioException catch (e) {
      print('❌ Labour API Error: ${e.message}');
      print('❌ Status Code: ${e.response?.statusCode}');
      print('❌ Response Data: ${e.response?.data}');
      rethrow;
    }
  }
}