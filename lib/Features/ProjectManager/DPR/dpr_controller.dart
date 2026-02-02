import 'package:dio/dio.dart';
import 'DPRHistory/DprModal.dart';
import 'DprModule.dart';
import 'DprServiesss.dart';
import 'dart:convert';



class DPRController {
  final DPRApiService _service = DPRApiService();

  Future<void> createDPR(DPRModel dpr) async {
    try {
      final jsonData = dpr.toJson();

      print('');
      print('🚀 ========== SENDING DPR TO BACKEND ==========');
      print('📋 Endpoint: POST /api/dpr');
      print('📦 Request Body:');
      print(JsonEncoder.withIndent('  ').convert(jsonData));
      print('===============================================');
      print('');

      final Response response = await _service.createDPR(jsonData);

      print('');
      print('✅ ========== BACKEND RESPONSE ==========');
      print('📊 Status Code: ${response.statusCode}');
      print('📦 Response Data:');
      print(JsonEncoder.withIndent('  ').convert(response.data));
      print('=========================================');
      print('');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw response.data['message'] ?? 'Failed to create DPR';
      }
    } on DioException catch (e) {
      print('');
      print('❌ ========== API ERROR ==========');
      print('⚠️  Error Type: ${e.type}');
      print('⚠️  Error Message: ${e.message}');
      print('⚠️  Status Code: ${e.response?.statusCode}');
      print('⚠️  Response Data: ${e.response?.data}');
      print('==================================');
      print('');

      throw e.response?.data['message'] ?? 'Failed to create DPR';
    } catch (e) {
      print('');
      print('❌ ========== UNEXPECTED ERROR ==========');
      print('⚠️  Error: $e');
      print('=========================================');
      print('');
      rethrow;
    }
  }





  Future<List<DPRListItem>> getDPRs({int page = 1, int limit = 20}) async {
    try {
      print('📋 Fetching DPRs...');

      final Response response = await _service.getDPRs(page: page, limit: limit);

      print('✅ DPR Response: ${response.data}');

      if (response.data == null || response.data['data'] == null) {
        print('⚠️ No DPR data found');
        return [];
      }

      final List<dynamic> dprList = response.data['data'];

      print('✅ Found ${dprList.length} DPRs');

      return dprList.map((json) => DPRListItem.fromJson(json)).toList();

    } on DioException catch (e) {
      print('❌ Error fetching DPRs: ${e.message}');
      throw e.response?.data['message'] ?? 'Failed to load DPRs';
    }
  }

  Future<Map<String, dynamic>> getDPRDetails(int id) async {
    try {
      print('📋 Fetching DPR details for ID: $id');

      final Response response = await _service.getDPRById(id);

      print('✅ DPR Details Response: ${response.data}');

      if (response.data == null || response.data['data'] == null) {
        throw 'DPR details not found';
      }

      return response.data['data'];

    } on DioException catch (e) {
      print('❌ Error fetching DPR details: ${e.message}');
      throw e.response?.data['message'] ?? 'Failed to load DPR details';
    }
  }
}