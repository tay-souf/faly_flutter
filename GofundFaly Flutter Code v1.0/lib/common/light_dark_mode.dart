import 'package:flutter/material.dart';
import 'package:gofunds/common/common_button.dart';

class ColorNotifier with ChangeNotifier {

  get background => isDark ? const Color(0xff151619) : Colors.white;
  get containercolore => isDark ? const Color(0xff1E1F23) : greaycolore;
  get textcolore => isDark ?  Colors.white : Colors.black;
  get fagcontainer => isDark ? const Color(0xff1C1C1C) :  const Color(0xffEEEEEE);

  bool _isDark = false;
  bool get isDark => _isDark;

  void isAvailable(bool value) {
    _isDark = value;
    notifyListeners();
  }

}

