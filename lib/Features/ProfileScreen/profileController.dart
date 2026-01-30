import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  Map<String, dynamic>? data;

  void setProfile(Map<String, dynamic> response) {
    data = response;
    notifyListeners();
  }

  void clear() {
    data = null;
    notifyListeners();
  }
}
