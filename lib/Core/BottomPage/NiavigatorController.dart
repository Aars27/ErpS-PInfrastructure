import 'package:flutter/material.dart';

class MainNavigationController extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isVisible = true; // Track visibility

  int get currentIndex => _currentIndex;
  bool get isVisible => _isVisible;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setVisible(bool visible) {
    if (_isVisible == visible) return;
    _isVisible = visible;
    notifyListeners();
  }
}