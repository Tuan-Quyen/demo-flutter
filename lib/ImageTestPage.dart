import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'models/local/CameraImageVideo.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key}) : super(key: key);

  @override
  _MyImageTestPageState createState() => new _MyImageTestPageState();
}

class _MyImageTestPageState extends State<ImagePage> {
  String currentSelected = "";
  List<String> preview = [];
  List<ImageProvider> _listProvider = [];
  Future<void> _initializeVideoPlayerFuture;
  String videoPath;

  VideoPlayerController _controller;
  String path;

  checkPermissionGallery() async {
    final statusStorage = await CheckPermission().checkPermissionStorage();
    if (statusStorage) {
      _navigateImagePicker(context);
    }
  }

  _navigateImagePicker(BuildContext context) async {
    await Navigator.pushNamed(context, "/MultiImagePage").then((value) {
      setState(() {
        videoPath = null;
        _controller = null;
        _initializeVideoPlayerFuture = null;
      });
      List<String> list = [];
      value != null ? list.addAll(value) : null;
      for (int i = 0; i < list.length; i++) {
        testCompressFile(File(list[i]));
      }
    });
  }

  _navigateCamera(BuildContext context) async {
    final result = await Navigator.pushNamed(context, "/CameraPage");
    FilePathImageVideo filePathImageVideo;
    result != null ? filePathImageVideo = result : filePathImageVideo = null;
    if (filePathImageVideo != null) {
      if (filePathImageVideo.isImage) {
        setState(() {
          videoPath = null;
          testCompressFile(File(filePathImageVideo.filePath));
          _controller = null;
          _initializeVideoPlayerFuture = null;
        });
      } else if (!filePathImageVideo.isImage) {
        setState(() {
          preview.clear();
          _listProvider.clear();
          videoPath = filePathImageVideo.filePath;
          _controller = VideoPlayerController.file(File(videoPath));
          _initializeVideoPlayerFuture = _controller.initialize();
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Container display() {
    if (videoPath != null) {
      return Container(
          child: _controller != null
              ? FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    return GestureDetector(
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
                    );
                  })
              : Container());
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
              return Image(
                image: _listProvider[position],
                fit: BoxFit.fill,
                filterQuality: FilterQuality.low,
              );
            }),
      );
    }
  }

  Future<List<int>> testCompressFile(File file) async {
    await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 120,
      minHeight: 120,
      quality: 50,
    ).then((value) {
      ImageProvider provider = MemoryImage(Uint8List.fromList(value));
      _listProvider.add(provider);
      preview.add(file.path);
    });
    if (this.mounted) {
      setState(() {});
    }
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
