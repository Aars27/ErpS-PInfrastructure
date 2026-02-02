import 'package:dio/dio.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';

class MaterialApiService {
  final ApiService _api = ApiService(type: ApiType.app);

  Future<Response> getMaterials({int page = 1, int limit = 100}) async {
    try {
      print('📦 Calling Material API: ${ApiConstants.material}');

      final response = await _api.get(
        ApiConstants.material,
        headers: {
          'x-module': 'Inventory Management',
        },
      );

      print('✅ Material API Status: ${response.statusCode}');
      print('✅ Material API Data Type: ${response.data.runtimeType}');

      return response;

    } on DioException catch (e) {
      print('❌ Material API Error: ${e.message}');
      print('❌ Status Code: ${e.response?.statusCode}');
      print('❌ Response Data: ${e.response?.data}');
      rethrow;
    }
  }
}