import 'package:dio/dio.dart';
import 'LabourModal.dart';
import 'LabourServieces.dart';




class LabourController {
  final LabourApiService _service = LabourApiService();

  Future<List<LabourItem>> fetchLabours() async {
    try {
      print('👷 Fetching labours from API...');

      final Response response = await _service.getLabours();

      print('✅ Labour API Response: ${response.data}');

      // Check if response.data is Map or has 'labours' key
      if (response.data == null) {
        print('❌ Response data is null');
        return [];
      }

      List<dynamic> laboursList;

      // Handle different response formats
      if (response.data is Map) {
        // If response is a Map with 'labours' key
        laboursList = response.data['labours'] ?? [];
      } else if (response.data is List) {
        // If response is directly a List
        laboursList = response.data;
      } else {
        print('❌ Unexpected response format: ${response.data.runtimeType}');
        return [];
      }

      print('✅ Labours count: ${laboursList.length}');

      if (laboursList.isEmpty) {
        print('⚠️ No labours found in response');
        return [];
      }

      final labours = laboursList.map((e) {
        print('👷 Parsing labour: ${e['labour_name']}');
        return LabourItem.fromJson(e);
      }).toList();

      print('✅ Successfully parsed ${labours.length} labours');
      return labours;

    } on DioException catch (e) {
      print('❌ DioException: ${e.message}');
      print('❌ Response: ${e.response?.data}');
      throw e.response?.data['message'] ?? 'Failed to load labours';
    } catch (e) {
      print('❌ Error: $e');
      rethrow;
    }
  }
}