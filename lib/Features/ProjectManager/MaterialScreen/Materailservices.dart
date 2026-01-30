import 'package:dio/dio.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';



class MaterialApiService {
  final ApiService _api = ApiService(type: ApiType.app);

  Future<Response> getMaterials({int page = 1, int limit = 10}) async {
    return await _api.get(
      ApiConstants.material,
      headers: {
        'x-module': 'Inventory Management',
      },
    );
  }
}
