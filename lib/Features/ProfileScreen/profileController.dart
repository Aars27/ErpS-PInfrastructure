import 'package:flutter/material.dart';
import 'package:smp_erp/Features/ProfileScreen/profile_modal.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Constants/ApiService.dart';
import '../../../Core/Storage/local_storage.dart';




class ProfileController extends ChangeNotifier {
  final ApiService _api = ApiService(type: ApiType.auth);

  ProfileModel? profile;
  bool isLoading = false;

  Future<void> fetchProfile() async {
    try {
      debugPrint(" FETCHING PROFILE...");

      // Check token before making request
      String? token = await LocalStorage.getToken();
      debugPrint(" Token check: ${token != null ? 'EXISTS (${token.substring(0, 20)}...)' : 'NULL'}");

      isLoading = true;
      notifyListeners();

      final res = await _api.get(ApiConstants.profile);

      debugPrint(' PROFILE RESPONSE: ${res.data}');
      debugPrint(' STATUS CODE: ${res.statusCode}');
      if (res.statusCode == 200 && res.data != null) {
        if (res.data['status'] == 200 && res.data['user'] != null) {
          profile = ProfileModel.fromJson(res.data['user']);
          debugPrint(' Profile loaded: ${profile?.name}');
        } else if (res.data['success'] == false) {
          debugPrint(' API returned error: ${res.data['message']}');
        } else {
          debugPrint(' Unexpected response structure');
        }
      }
    } catch (e) {
      debugPrint('PROFILE ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
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