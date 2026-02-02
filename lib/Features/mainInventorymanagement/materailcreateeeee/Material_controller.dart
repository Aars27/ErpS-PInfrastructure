import 'package:flutter/material.dart';
import '../../../Constants/ApiService.dart';
import '../../../Constants/ApiConstants.dart';
import 'materailmodalcreate.dart';



class MaterialController extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;
  List<MaterialModel> materials = [];

  /// GET – Material History
  Future<void> fetchMaterials() async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await _api.get(ApiConstants.material);
      final List list = res.data['materials'];

      materials = list.map((e) => MaterialModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('❌ MATERIAL FETCH ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// POST – Add Material
  Future<void> addMaterial(
      BuildContext context, {
        required String name,
        required int categoryId,
        required int unitId,
        required String status,
        required int minThreshold,
        required String materialCode,
      }) async {
    try {
      await _api.post(
        ApiConstants.material,
        {
          "name": name,
          "categoryId": categoryId,
          "unitId": unitId,
          "status": status,
          "minimum_threshold_quantity": minThreshold,
          "material_code": materialCode,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Material added successfully')),
      );

      await fetchMaterials();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add material')),
      );
    }
  }
}
