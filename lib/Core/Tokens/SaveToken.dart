// lib/utils/shared_preferences_helper.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyRoleId = 'role_id';
  static const String _keyRoleName = 'role_name';
  static const String _keyExpireTime = 'expire_time';
  static const String _keyUserData = 'user_data';
  static const String _keyIsLoggedIn = 'is_logged_in';

  // Save login data
  static Future<bool> saveLoginData({
    required String accessToken,
    required String refreshToken,
    required int userId,
    required String userName,
    required String userEmail,
    required int roleId,
    required String roleName,
    required int expireTime,
    required Map<String, dynamic> userData,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyAccessToken, accessToken);
      await prefs.setString(_keyRefreshToken, refreshToken);
      await prefs.setInt(_keyUserId, userId);
      await prefs.setString(_keyUserName, userName);
      await prefs.setString(_keyUserEmail, userEmail);
      await prefs.setInt(_keyRoleId, roleId);
      await prefs.setString(_keyRoleName, roleName);
      await prefs.setInt(_keyExpireTime, expireTime);
      await prefs.setString(_keyUserData, jsonEncode(userData));
      await prefs.setBool(_keyIsLoggedIn, true);
      return true;
    } catch (e) {
      print('Error saving login data: $e');
      return false;
    }
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken);
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRefreshToken);
  }

  // Get user ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  // Get user name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  // Get role ID
  static Future<int?> getRoleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyRoleId);
  }

  // Get role name
  static Future<String?> getRoleName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRoleName);
  }

  // Get expire time
  static Future<int?> getExpireTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyExpireTime);
  }

  // Get user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_keyUserData);
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Clear all data (logout)
  static Future<bool> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }

  // Update access token
  static Future<bool> updateAccessToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyAccessToken, token);
      return true;
    } catch (e) {
      print('Error updating access token: $e');
      return false;
    }
  }
}