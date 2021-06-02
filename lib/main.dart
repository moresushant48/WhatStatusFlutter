import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:whatstatus_flutter/HomePage.dart';
import 'package:one_context/one_context.dart';

void main() {
  runApp(MainHome());
}

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            builder: OneContext().builder,
            navigatorKey: OneContext().key,
            theme: ThemeProvider.themeOf(themeContext).data,
            home: HomePage(),
          ),
        ),
      ),
    );
  }
}
