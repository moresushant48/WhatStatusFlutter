import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:whatstatus_flutter/GetData.dart';
import 'package:whatstatus_flutter/ViewMedia.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  List<String> _videoList = [];

  @override
  void initState() {
    super.initState();

    getVideos();
  }

  getVideos() async {
    _videoList = await GetData.getVideos(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {});
        return Future.value(0);
      },
      child: FutureBuilder(
        future: GetData.getVideos(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AnimationLimiter(
              child: FutureBuilder(
                future: GetData.getThumbnail(snapshot.data),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.done
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: Duration(milliseconds: 400),
                              child: SlideAnimation(
                                verticalOffset: 100.0,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image(
                                          image: FileImage(File(
                                              snapshot.data[index].toString())),
                                          fit: BoxFit.cover,
                                        ),
                                        Icon(
                                          Icons.play_circle_fill,
                                          size: 40.0,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewMedia(
                                                  dataList: _videoList,
                                                  currentIndex: index,
                                                  category:
                                                      ViewMedia.CATEGORY_VIDEOS,
                                                )),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
