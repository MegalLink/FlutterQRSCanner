import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode;
  MaterialColor? color;

  ThemeProvider({required this.isDarkMode, required String hexColor}) {
    color = _hexToMaterialColor(hexColor);
  }

  setThemeMode(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }

  setHexThemeColor(String hexColor) {
    color = _hexToMaterialColor(hexColor);
    notifyListeners();
  }

  setThemeColor(Color color) {
    this.color = generateMaterialColor(color: color);
    notifyListeners();
  }

  MaterialColor _hexToMaterialColor(String code) {
    final Color hexColor =
        Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

    return generateMaterialColor(color: hexColor);
  }
}
