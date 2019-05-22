import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'models/local/CameraImageVideo.dart';

class ImageTestPage extends StatefulWidget {
  ImageTestPage({Key key}) : super(key: key);

  @override
  _MyImageTestPageState createState() => new _MyImageTestPageState();
}

class _MyImageTestPageState extends State<ImageTestPage> {
  String currentSelected = "";
  List<String> preview = [];
  String videoPath;
  VideoPlayerController _controller;
  String path;

  checkPermissionGallery() async {
    final statusStorage = await CheckPermission().checkPermissionStorage();
    if (statusStorage) {
      _navigateImagePicker(context);
    } else {
      setState(() {});
    }
  }

  _navigateImagePicker(BuildContext context) async {
    final result = await Navigator.pushNamed(context, "/MultiImagePage");
    setState(() {
      result != null ? preview.addAll(result) : null;
      print(preview);
    });
  }

  _navigateCamera(BuildContext context) async {
    final result = await Navigator.pushNamed(context, "/CameraPage");
    FilePathImageVideo filePathImageVideo;
    setState(() {
      result != null ? filePathImageVideo = result : filePathImageVideo = null;
      if (filePathImageVideo != null) {
        if (filePathImageVideo.isImage) {
          videoPath = null;
          _controller.dispose();
          preview.add(filePathImageVideo.filePath);
        } else if (!filePathImageVideo.isImage) {
          preview.clear();
          videoPath = filePathImageVideo.filePath;
          _controller = VideoPlayerController.file(File(videoPath))
            ..initialize();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Container display() {
    if (videoPath != null) {
      return Container(
        child: _controller.value.initialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    children: <Widget>[
                      VideoPlayer(_controller),
                      Center(
                        child: Visibility(
                            visible: !_controller.value.isPlaying,
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                            )),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      );
    } else {
      return displayImage();
    }
  }

  Container displayImage() {
    if (preview.length == 1) {
      return Container(
          child: Image.file(
        File(preview[0]),
        filterQuality: FilterQuality.low,
        fit: BoxFit.fill,
      ));
    } else {
      return Container(
        child: GridView.builder(
            itemCount: preview.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (BuildContext, position) {
              print(preview[position]);
              return FutureBuilder(
                  future: testCompressFile(File(preview[position])),
                  builder: (BuildContext, snapshot) {
                    if (snapshot.hasData) {
                      ImageProvider provider =
                          MemoryImage(Uint8List.fromList(snapshot.data));
                      return Image(
                        image: provider,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.low,
                      );
                    } else {
                      return Container();
                    }
                  });
            }),
      );
    }
  }

  Future<List<int>> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 120,
      minHeight: 120,
      quality: 50,
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("asdasd"),
      ),
      body: display(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => _navigateCamera(context),
            child: new Icon(Icons.camera_alt),
            heroTag: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: () => checkPermissionGallery(),
              child: new Icon(Icons.photo_library),
              heroTag: 1,
            ),
          ),
        ],
      ),
    );
  }
}
