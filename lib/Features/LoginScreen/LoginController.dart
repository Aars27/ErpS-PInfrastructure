import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/ApiConstants.dart';
import '../../Constants/ApiService.dart';
import '../../Core/Router/AppRoutes.dart';
import '../../Core/Storage/local_storage.dart';
import '../ProfileScreen/profileController.dart';


class AuthController {
  static Future<void> login(
      BuildContext context,
      String email,
      String password,
      ) async {
    try {
      final api = ApiService(type: ApiType.auth);

      final res = await api.post(
        ApiConstants.login,
        {
          "email": email,
          "password": password,
        },
      );

      final data = res.data;

      if (data['status'] == 200) {
        //  SAVE TOKEN + USER + USER ID (ONE PLACE)
        await LocalStorage.saveAuth(data);

        // SET PROFILE (UI STATE)
        // context.read<ProfileController>().setProfile(data['user']);

        // GO TO DASHBOARD
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.dashboard,
        );
      } else {
        _error(context, 'Invalid credentials');
      }
    } catch (e) {
      _error(context, 'Login failed');
    }
  }

  static void _error(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
