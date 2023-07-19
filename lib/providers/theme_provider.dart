import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isLight = false;
  set isLight(value) {
    _isLight = value;
  
  }

  bool get isLight => _isLight;
  void changeTheme() {
    _isLight = !_isLight;

    notifyListeners();
  }
}
