import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:whatstatus_flutter/FancyFab.dart';

class ViewMedia extends StatefulWidget {
  static const String CATEGORY_IMAGES = "IMAGES";
  static const String CATEGORY_VIDEOS = "VIDEOS";

  final List<String> dataList;
  final int currentIndex;
  final String category;

  ViewMedia(
      {@required this.dataList,
      @required this.currentIndex,
      @required this.category});

  @override
  _ViewMediaState createState() => _ViewMediaState();
}

class _ViewMediaState extends State<ViewMedia> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  int currentIndex;

  @override
  void initState() {
    super.initState();
    this.currentIndex = widget.currentIndex;
    if (widget.category == ViewMedia.CATEGORY_VIDEOS)
      initializeVideoController(widget.currentIndex);
  }

  initializeVideoController(int index) {
    if (widget.category == ViewMedia.CATEGORY_VIDEOS) {
      _videoPlayerController = VideoPlayerController.file(
        File(widget.dataList[index].toString()),
      );
      _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        allowFullScreen: false,
        errorBuilder: (context, errorMessage) =>
            Text("Something Went Wrong..!"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: widget.category == ViewMedia.CATEGORY_IMAGES
            ? CarouselSlider.builder(
                itemCount: widget.dataList.length,
                options: CarouselOptions(
                  scrollPhysics: BouncingScrollPhysics(),
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  height: MediaQuery.of(context).size.height,
                  enableInfiniteScroll: false,
                  initialPage: widget.currentIndex,
                ),
                itemBuilder: (context, index, realIndex) {
                  initializeVideoController(index);
                  this.currentIndex = index;
                  return Scaffold(
                    backgroundColor: Colors.black,
                    body: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: PinchZoom(
                          // fit: BoxFit.fitWidth,
                          image: Image.file(
                              File(widget.dataList[index].toString())),
                        )),
                    floatingActionButton: FancyFab(
                      data: widget.dataList[this.currentIndex],
                    ),
                  );
                },
              )
            : Chewie(
                controller: _chewieController,
              ),
      ),
      floatingActionButton: widget.category == ViewMedia.CATEGORY_VIDEOS
          ? FancyFab(
              data: widget.dataList[this.currentIndex],
            )
          : null,
    );
  }

  @override
  void dispose() {
    if (widget.category == ViewMedia.CATEGORY_VIDEOS) {
      _videoPlayerController.dispose();
      _chewieController.dispose();
    }
    super.dispose();
  }
}
