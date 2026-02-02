import 'package:dio/dio.dart';

import 'Materailservices.dart';
import 'NewMaterialModal.dart';





class MaterialController {
  final MaterialApiService _service = MaterialApiService();

  Future<List<MaterialItem>> fetchMaterials() async {
    try {
      print('📦 Fetching materials from API...');

      final Response response = await _service.getMaterials();

      print('✅ Material API Response: ${response.data}');

      // Check if response.data is Map or has 'materials' key
      if (response.data == null) {
        print('❌ Response data is null');
        return [];
      }

      List<dynamic> materialsList;

      // Handle different response formats
      if (response.data is Map) {
        // If response is a Map with 'materials' key
        materialsList = response.data['materials'] ?? [];
      } else if (response.data is List) {
        // If response is directly a List
        materialsList = response.data;
      } else {
        print('❌ Unexpected response format: ${response.data.runtimeType}');
        return [];
      }

      print('✅ Materials count: ${materialsList.length}');

      if (materialsList.isEmpty) {
        print('⚠️ No materials found in response');
        return [];
      }

      final materials = materialsList.map((e) {
        print('📦 Parsing material: ${e['name']}');
        return MaterialItem.fromJson(e);
      }).toList();

      print('✅ Successfully parsed ${materials.length} materials');
      return materials;

    } on DioException catch (e) {
      print('❌ DioException: ${e.message}');
      print('❌ Response: ${e.response?.data}');
      throw e.response?.data['message'] ?? 'Failed to load materials';
    } catch (e) {
      print('❌ Error: $e');
      rethrow;
    }
  }
}