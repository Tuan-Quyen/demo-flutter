import 'dart:async';
import 'dart:io' show Directory, Platform;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:path_provider/path_provider.dart';

import 'models/local/CameraImageVideo.dart';

List<CameraDescription> cameras;

class TakePictureScreen extends StatefulWidget {
  TakePictureScreen({Key key}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  bool check = false, isVideo = false;
  String videoPath;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  Future<void> _futureCamera() async {
    cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    _futureCamera();
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
        initCamera(0);
      });
    } else {
      setState(() {
        Navigator.pop(context);
      });
    }
  }

  void initCamera(int cameraType) {
    _controller = CameraController(cameras[cameraType], ResolutionPreset.high,
        enableAudio: isVideo);
    _initializeControllerFuture = _controller.initialize();
  }

  Future<String> pathImage() async {
    String filePath;
    if (Platform.isAndroid) {
      final Directory appDirectory = await getExternalStorageDirectory();
      final String pictureDirectory = '${appDirectory.path}/DCIM/Camera';
      await Directory(pictureDirectory).create(recursive: true);
      final String currentTime =
          DateTime.now().millisecondsSinceEpoch.toString();
      filePath = '$pictureDirectory/IMG_${currentTime}.jpg';
    }
    await _controller.takePicture(filePath);
    Navigator.pop(context, FilePathImageVideo(filePath, true));
  }

  Future<String> startRecordVideo() async {
    if (Platform.isAndroid) {
      final Directory appDirectory = await getExternalStorageDirectory();
      final String videoDirectory = '${appDirectory.path}/DCIM/Camera';
      await Directory(videoDirectory).create(recursive: true);
      final String currentTime =
          DateTime.now().millisecondsSinceEpoch.toString();
      videoPath = '$videoDirectory/VID_${currentTime}.mp4';
    }
    await _controller.startVideoRecording(videoPath);
  }

  Future<String> stopRecordVideo() async {
    await _controller.stopVideoRecording().then((value) {
      setState(() {
        if (isVideo == true) {
          isVideo = false;
        }
        Navigator.pop(context, FilePathImageVideo(videoPath, false));
      });
    });
  }

  Future initFutureCamera(bool startRecord) async {
    try {
      await _initializeControllerFuture;
      if (!isVideo) {
        pathImage();
      } else {
        startRecord ? startRecordVideo() : stopRecordVideo();
      }
    } catch (e) {
      print(e);
    }
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
            return Container(
              color: Colors.black,
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 0,
              onPressed: () {
                if (!check) {
                  setState(() {
                    check = true;
                    _initializeControllerFuture = null;
                    initCamera(1);
                  });
                } else {
                  setState(() {
                    check = false;
                    _initializeControllerFuture = null;
                    initCamera(0);
                  });
                }
              },
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(90 / 360),
                child: Icon(
                  Icons.sync,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              //margin: const EdgeInsets.only(left: 40, right: 40),
              child: FloatingActionButton(
                heroTag: 1,
                backgroundColor: isVideo ? Colors.red : Colors.white,
                child: isVideo
                    ? null
                    : Icon(Icons.camera_alt, color: Colors.black),
                shape: CircleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 1)),
                onPressed: () {
                  initFutureCamera(false);
                },
              ),
            ),
            Visibility(
                visible: !isVideo,
                replacement: Container(
                  width: 50,
                  height: 50,
                ),
                child: FloatingActionButton(
                    heroTag: 2,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.videocam,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isVideo = true;
                      });
                      initFutureCamera(true);
                    }))
          ],
        ),
      ),
    );
  }
}
