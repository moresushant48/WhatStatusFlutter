import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatstatus_flutter/ImagesPage.dart';
import 'package:whatstatus_flutter/PermissionsManager.dart';
import 'package:whatstatus_flutter/VideosPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isPermGranted = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() {
    Permission.storage.isGranted.then((val) {
      if (val) {
        _isPermGranted = val;
        setState(() {});
      }
    });
  }

  final _pageList = [ImagesPage(), VideosPage()];

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(child: Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("WhatStatus"),
            centerTitle: true,
            actions: [
              ThemeSwitcher(
                clipper: ThemeSwitcherCircleClipper(),
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.brightness_6),
                    onPressed: () {
                      ThemeSwitcher.of(context).changeTheme(
                          theme: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? ThemeData.dark()
                              : ThemeData.light());
                    },
                  );
                },
              )
            ],
          ),
          body: _isPermGranted
              ? _pageList[_currentIndex]
              : Container(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emoji_emotions,
                        color: Colors.grey,
                        size: 160,
                      ),
                      Text(
                        "Allow Storage to View WhatsApp Status.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 20.0),
                      ),
                      SizedBox(height: 12.0),
                      MaterialButton(
                        child: Text("Allow"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () async {
                          PermissionManager.askForPermission().then((val) {
                            if (val)
                              setState(() {
                                _isPermGranted = true;
                              });
                          });
                        },
                      )
                    ],
                  ),
                ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            elevation: 10.0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.image),
                label: "Images",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_library),
                label: "Videos",
              )
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        );
      },
    ));
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
