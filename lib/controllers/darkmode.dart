import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeSettings() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    _isDark = _prefs.getBool('isDark') ?? false;
    notifyListeners();
  }

  Future<void> setDark(bool value) async {
    _isDark = value;
    await _prefs.setBool('isDark', value);
    notifyListeners(); // Notifica todos os ouvintes
  }
}
