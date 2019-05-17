import 'dart:async';
import 'dart:io' show Directory, Platform;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;


//quay camera
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    //initCamera();
    checkPermission();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  checkPermission() async {
    final statusCamera = await CheckPermission().checkPermissionCamera();
    final statusStorage = await CheckPermission().checkPermissionStorage();
    final statusMicroPhone =
        await CheckPermission().checkPermissionMicroPhone();
    if (statusCamera && statusMicroPhone && statusStorage) {
      setState(() {
        initCamera();
      });
    } else {
      setState(() {
        Navigator.pop(context);
      });
    }
  }

  void initCamera() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  Future<String> pathImage() async {
    String filePath;
    if (Platform.isAndroid) {
      final Directory appDirectory = await getExternalStorageDirectory();
      final String pictureDirectory = '${appDirectory.path}/Pictures';
      await Directory(pictureDirectory).create(recursive: true);
      final String currentTime =
          DateTime.now().millisecondsSinceEpoch.toString();
      filePath = '$pictureDirectory/${currentTime}.jpg';
    } else if (Platform.isIOS) {
      filePath = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
    }
    await _controller.takePicture(filePath);
    Navigator.pop(context, filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: FloatingActionButton(
              child: Icon(Icons.camera_alt),
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  pathImage();
                } catch (e) {
                  print(e);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
