import 'package:flutter/material.dart';
import 'package:smp_erp/Features/ProfileScreen/profile_modal.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';
import '../../../Core/Storage/local_storage.dart';




class ProfileController extends ChangeNotifier {
  ProfileModel? profile;
  bool isLoading = false;

  Future<void> fetchProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await LocalStorage.getToken();

      if (token == null) {
        throw Exception('Token not found');
      }

      final api = ApiService(type: ApiType.auth);

      final res = await api.get(
        '/user/profile',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (res.data['status'] == 200) {
        profile = ProfileModel.fromJson(res.data['user']);
      }
    } catch (e) {
      debugPrint('❌ PROFILE ERROR: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await LocalStorage.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (_) => false,
    );
  }
}
