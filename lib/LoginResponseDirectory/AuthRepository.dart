import 'package:smp_erp/Constants/ApiConstants.dart';
import 'package:smp_erp/Constants/ApiService.dart';
import 'package:smp_erp/LoginResponseDirectory/LoginRequest.dart';
import 'package:smp_erp/LoginResponseDirectory/LoginResponse.dart';
import 'package:smp_erp/SharedPreffrence/SharedPreferencesHelper.dart';

class AuthRepository {
  // Login API call
  static Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final response = await ApiService.post(
        ApiConstants.login,
        loginRequest.toJson(),
        requiresAuth: false,
      );

      final loginResponse = LoginResponse.fromJson(response);

      // Save login data to shared preferences
      await SharedPreferencesHelper.saveLoginData(
        accessToken: loginResponse.token,
        refreshToken: loginResponse.refreshToken,
        userId: loginResponse.user.id,
        userName: loginResponse.user.name,
        userEmail: loginResponse.user.email,
        roleId: loginResponse.user.roleId,
        roleName: loginResponse.user.role.name,
        expireTime: loginResponse.expireTime,
        userData: loginResponse.user.toJson(),
      );

      return loginResponse;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Logout API call (optional - if you have a logout endpoint)
  static Future<void> logout() async {
    try {
      // If you have a logout endpoint, uncomment below
      // await ApiService.post(ApiConstants.logout, {}, requiresAuth: true);

      // Clear all data from shared preferences
      await SharedPreferencesHelper.clearAllData();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  // Refresh Token API call
  static Future<String> refreshToken() async {
    try {
      final refreshToken = await SharedPreferencesHelper.getRefreshToken();

      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await ApiService.post(
        ApiConstants.refreshToken,
        {'refreshToken': refreshToken},
        requiresAuth: false,
      );

      final newAccessToken = response['token'];

      // Update access token in shared preferences
      await SharedPreferencesHelper.updateAccessToken(newAccessToken);

      return newAccessToken;
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    return await SharedPreferencesHelper.isLoggedIn();
  }

  // Get current user data
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    return await SharedPreferencesHelper.getUserData();
  }
}