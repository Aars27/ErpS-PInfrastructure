import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../Constants/ApiService.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Core/Storage/local_storage.dart';
import 'Categorymodal.dart';

class CategoryController extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;
  List<CategoryModel> categories = [];

  /// GET – Category History
  Future<void> fetchCategories() async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await _api.get(ApiConstants.category);

      // ✅ BACKEND KEY
      final List list = res.data['categories'];

      categories = list.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('❌ CATEGORY FETCH ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// POST – Add Category
  Future<void> addCategory(
      BuildContext context, {
        required String name,
        required String description,
      }) async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await LocalStorage.getToken();

      final res = await _api.post(
        ApiConstants.category,
        {
          "name": name,
          "description": description,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'x-module': 'Inventory Management',
          'action-perform': 'create',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        await fetchCategories(); // ✅ refresh list

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.data['message']),
          ),
        );
      }
    } on DioException catch (e) {
      debugPrint('❌ ADD CATEGORY ERROR: ${e.response?.data}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data['message'] ?? 'Failed to add category',
          ),
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
