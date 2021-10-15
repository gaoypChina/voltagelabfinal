import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Otherprovider extends ChangeNotifier {
  double textsize = 15.0;
  bool darkmode = false;

  ThemeData? themeData;

  void textsizecontroll(double values) {
    textsize = values;
    notifyListeners();
  }

  settheme(ThemeData _theme, bool _darkmode) {
    themeData = _theme;
    darkmode = _darkmode;
    notifyListeners();
  }
}
