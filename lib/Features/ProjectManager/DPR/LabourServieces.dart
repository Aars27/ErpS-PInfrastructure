import 'package:dio/dio.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';

class LabourApiService {
  final ApiService _api = ApiService(type: ApiType.app);

  Future<Response> getLabours({int page = 1, int limit = 100}) async {
    return await _api.get(
      ApiConstants.labour,
      headers: {
        'x-module': 'Labour Management',
      },
    );
  }
}