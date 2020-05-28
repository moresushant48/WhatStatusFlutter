import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:whatstatus_flutter/HomePage.dart';

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

    Screen.keepOn(true); // keeps screen on all the time.

    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
