import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:flutter_app/widgets/CustomLoadVideo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:thumbnails/thumbnails.dart';
import 'PreviewPage.dart';
import 'models/local/CameraImageVideo.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key}) : super(key: key);

  @override
  _MyImageTestPageState createState() => new _MyImageTestPageState();
}

class _MyImageTestPageState extends State<ImagePage> {
  String currentSelected = "";
  List<FilePathImageVideo> preview = [];
  List<ImageProvider> _listProvider = [];
  Future<void> _initializeVideoPlayerFuture;

  VideoPlayerController _controller;
  String path;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  checkPermissionGallery() async {
    final statusStorage = await CheckPermission().checkPermissionStorage();
    if (statusStorage) {
      _navigateImagePicker(context);
    }
  }

  _navigateImagePicker(BuildContext context) async {
    await Navigator.pushNamed(context, "/MultiImagePage").then((value) {
      setState(() {
        _controller = null;
        _initializeVideoPlayerFuture = null;
      });
      List<String> list = [];
      value != null ? list.addAll(value) : null;
      for (int i = 0; i < list.length; i++) {
        testCompressFile(File(list[i]), null, true);
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
          _controller = null;
          _initializeVideoPlayerFuture = null;
          testCompressFile(File(filePathImageVideo.filePath), null, true);
        });
      } else if (!filePathImageVideo.isImage) {
        setState(() {
          if (preview.length == 0) {
            _controller =
                VideoPlayerController.file(File(filePathImageVideo.filePath));
            _initializeVideoPlayerFuture = _controller.initialize();
          } else {
            _controller = null;
            _initializeVideoPlayerFuture = null;
          }
          getThumbVideo(filePathImageVideo.filePath);
        });
      }
    }
  }

  Future getThumbVideo(String path) async {
    final Directory appDirectory = await getTemporaryDirectory();
    String filePath = '${appDirectory.path}/Pictures';
    String thumb = await Thumbnails.getThumbnail(
        thumbnailFolder: filePath,
        videoFile: path,
        imageType: ThumbFormat.PNG,
        quality: 80);

    testCompressFile(File(thumb), path, false);
  }

  Future<List<int>> testCompressFile(
      File file, String orgirinPath, bool isImage) async {
    await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 120,
      minHeight: 120,
      quality: 80,
    ).then((value) {
      ImageProvider provider = MemoryImage(Uint8List.fromList(value));
      _listProvider.add(provider);
      if (!isImage) {
        preview.add(FilePathImageVideo(orgirinPath, isImage));
      } else {
        preview.add(FilePathImageVideo(file.path, isImage));
      }
    });
    if (this.mounted) {
      setState(() {});
    }
  }

  Center display() {
    if (preview.length == 1) {
      return Center(
          child: _controller != null
              ? FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    return CustomLoadVideo(_controller);
                  })
              : Image.file(
                  File(preview[0].filePath),
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.fill,
                ));
    } else if (preview.length == 0) {
      return Center(
        child: Container(),
      );
    }
  }

  Image displayImage(ImageProvider provider) {
    return Image(
      image: provider,
      fit: BoxFit.fill,
      filterQuality: FilterQuality.low,
    );
  }

  GestureDetector _itemView(int position) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    PreviewPage(filePathImageVideo: preview[position])));
      },
      child: Stack(fit: StackFit.expand, children: <Widget>[
        displayImage(_listProvider[position]),
        !preview[position].isImage
            ? Center(
                child: Container(
                width: 30,
                height: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
              ))
            : Container()
      ]),
    );
  }

  Container displayMultiImage() {
    return Container(
      child: GridView.builder(
          itemCount: preview.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemBuilder: (BuildContext, position) {
            return _itemView(position);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Display Image"),
      ),
      body: preview.length < 2 ? display() : displayMultiImage(),
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
