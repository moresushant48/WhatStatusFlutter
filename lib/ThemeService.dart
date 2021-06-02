import 'package:theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';

class ThemeService {
  void switchTheme(BuildContext context) {
    ThemeProvider.controllerOf(context).nextTheme();
  }
}

final themeService = ThemeService();
