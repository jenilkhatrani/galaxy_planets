import 'package:flutter/material.dart';
import 'package:galaxy_planets/Model/theme_model.dart';

class ThemeProvider with ChangeNotifier {
  ThemeModel themeModel = ThemeModel(isdark: false);

  void theme() {
    themeModel.isdark = !themeModel.isdark;
    notifyListeners();
  }
}
