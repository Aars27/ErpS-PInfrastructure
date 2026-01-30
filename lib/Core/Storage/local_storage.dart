import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/user_model.dart';

class LocalStorage {
  static final _storage = FlutterSecureStorage();

  //  SAVE LOGIN DATA
  static Future<void> saveAuth(Map<String, dynamic> data) async {
    await _storage.write(key: 'token', value: data['token']);
    await _storage.write(
      key: 'user',
      value: jsonEncode(data['user']),
    );

    //  SAVE USER ID SEPARATELY (IMPORTANT)
    await _storage.write(
      key: 'userId',
      value: data['user']['id'].toString(),
    );
  }

  //  TOKEN
  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // 👤 FULL USER
  static Future<UserModel?> getUser() async {
    final data = await _storage.read(key: 'user');
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  //  USER ID (THIS IS WHAT INVENTORY NEEDS)
  static Future<int?> getUserId() async {
    final id = await _storage.read(key: 'userId');
    if (id == null) return null;
    return int.tryParse(id);
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
