import 'package:flutter/material.dart';
import 'package:habittrackker/screens/theme/dark.dart';
import 'package:habittrackker/screens/theme/ligh.dart';

class ThemeProvider extends ChangeNotifier {
  
  //light mode at first
  ThemeData _themeData = light;

  //get theme
  ThemeData get themeData => _themeData;

  //check if dark mode
  bool get isDark => _themeData == dark;

  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //switch theme
  void switchTheme() {
    if (_themeData == light) {
      themeData = dark;
    } else {
      themeData = light;
    }
  }
}
