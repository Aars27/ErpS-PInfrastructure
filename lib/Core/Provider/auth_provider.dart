import 'package:flutter/material.dart';

import '../../Constants/ApiService.dart';
import '../../models/user_model.dart';
import '../Storage/local_storage.dart';




class AuthProvider with ChangeNotifier {
  UserModel? user;
  bool isLoggedIn = false;

  Future login(String url, Map body) async {
    final res = await ApiService().post(url, body);
    await LocalStorage.saveAuth(res.data);

    user = UserModel.fromJson(res.data['user']);
    isLoggedIn = true;
    notifyListeners();
  }

  Future autoLogin() async {
    final token = await LocalStorage.getToken();
    if (token != null) {
      user = await LocalStorage.getUser();
      isLoggedIn = true;
      notifyListeners();
    }
  }
}

