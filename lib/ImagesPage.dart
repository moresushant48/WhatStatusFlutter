import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:whatstatus_flutter/GetData.dart';
import 'package:whatstatus_flutter/ViewMedia.dart';

class ImagesPage extends StatefulWidget {
  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {});
        return Future.value(0);
      },
      child: FutureBuilder(
        future: GetData.getImages(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AnimationLimiter(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: 3,
                    position: index,
                    duration: Duration(milliseconds: 600),
                    child: SlideAnimation(
                      verticalOffset: 100.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          child: ParallaxImage(
                            extent: 100,
                            color: Colors.blueGrey,
                            image: FileImage(
                              File(
                                snapshot.data[index].toString(),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewMedia(
                                        dataList: snapshot.data,
                                        currentIndex: index,
                                        category: ViewMedia.CATEGORY_IMAGES,
                                      )),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else
            return Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
        },
      ),
    );
  }
}
