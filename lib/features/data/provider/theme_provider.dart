import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _load();
  }

  void toggleTheme() {
    _isDark = !_isDark;
    _save();
    notifyListeners();
  }

  void _load() {
    final box = Hive.box('tasksBox');
    _isDark = box.get('isDarkTheme', defaultValue: false) as bool;
  }

  void _save() {
    final box = Hive.box('tasksBox');
    box.put('isDarkTheme', _isDark);
  }
}
