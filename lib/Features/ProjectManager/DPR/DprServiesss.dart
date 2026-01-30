import 'package:dio/dio.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';

class DPRApiService {
  final ApiService _api = ApiService(type: ApiType.app);

  Future<Response> createDPR(Map<String, dynamic> dprData) async {
    return await _api.post(
      ApiConstants.dpr,
      dprData,  // This is the second positional argument
      headers: {
        'x-module': 'DPR Management',
        'action-perform': 'create',
      },
    );
  }

  Future<Response> getDPRs({int page = 1, int limit = 10}) async {
    return await _api.get(
      '${ApiConstants.dpr}?page=$page&limit=$limit',
      headers: {
        'x-module': 'DPR Management',
      },
    );
  }

  Future<Response> getDPRById(int id) async {
    return await _api.get(
      '${ApiConstants.dpr}/$id',
      headers: {
        'x-module': 'DPR Management',
      },
    );
  }
}