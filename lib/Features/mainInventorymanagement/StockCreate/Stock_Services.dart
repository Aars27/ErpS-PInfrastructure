import '../../../Constants/ApiService.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Core/Storage/local_storage.dart';



class StockService {
  final ApiService _api = ApiService();

  Future<void> createStock(Map<String, dynamic> body) async {
    final token = await LocalStorage.getToken();

    await _api.post(
      ApiConstants.stock,
      body,
      headers: {
        'Authorization': 'Bearer $token',
        'x-module': 'Inventory Management',
        'action-perform': 'create',
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );
  }
}
