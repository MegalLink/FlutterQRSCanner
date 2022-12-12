import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _preferences;
  static bool _isDarkMode = false;
  static String _color = "#0070ca";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String get color {
    return _preferences.getString('color') ?? _color;
  }

  static set color(String color) {
    _color = color;
    _preferences.setString('color', color);
  }

  static bool get isDarkMode {
    return _preferences.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    _preferences.setBool('isDarkMode', isDarkMode);
  }
}
