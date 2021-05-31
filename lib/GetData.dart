import 'dart:io';
import 'package:path/path.dart' as Path;

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:thumbnails/thumbnails.dart';

class GetData {
  static Future<List> getImages(BuildContext context) async {
    List list = await getFiles();
    list.removeWhere((item) => item.toString().endsWith('.mp4'));
    return list;
  }

  static Future<List> getVideos(BuildContext context) async {
    List list = await getFiles();
    list.removeWhere((item) => item.toString().endsWith('.jpg'));
    return list;
  }

  static Future<List<String>> getThumbnail(List<String> data) async {
    List<String> thumbList = [];
    for (var item in data) {
      thumbList.add(await Thumbnails.getThumbnail(
          videoFile: item, imageType: ThumbFormat.JPEG, quality: 30));
    }
    print("Length : " + thumbList.length.toString());
    return thumbList;
  }

  static Future<List<String>> getFiles() async {
    var path;
    Directory directory;

    path = await ExtStorage.getExternalStorageDirectory() +
        "/WhatsApp/Media/.Statuses";

    directory = Directory(path);

    List<FileSystemEntity> list = await directory.list().toList();
    List<String> pathList = [];

    for (FileSystemEntity item in list) {
      pathList.add(item.path);
    }
    pathList.removeWhere((item) => item.endsWith('.nomedia'));
    return pathList;
  }

  static Future<void> copyMediaToDownloads(String path) async {
    File file = File(path);
    Directory dir = Directory(await ExtStorage.getExternalStorageDirectory() +
        "/" +
        ExtStorage.DIRECTORY_DOWNLOADS +
        "/");
    File newFile = await file.copy(dir.path + Path.basename(file.path));
    print("In Downloads : " + newFile.path);
    return;
  }
}
