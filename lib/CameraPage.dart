import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
    initCamera();
    //checkPermission();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  /*checkPermission() async {
    final statusCamera = await checkPermissionCamera();
    final statusStorage = await checkPermissionStorage();
    final statusMicroPhone = await checkPermissionMicroPhone();
    if (statusCamera && statusMicroPhone && statusStorage) {
      setState(() {
        initCamera();
      });
    } else {
      setState(() {
        Navigator.pop(context);
      });
    }
  }*/

  checkPermissionStorage() async {
    PermissionStatus checkResultStorage = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (checkResultStorage.value == 0) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.storage]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
            if (status[PermissionGroup.storage].value == 2) {
              return true;
            } else {
              return false;
            }
          });
    } else {
      return true;
    }
  }

  checkPermissionCamera() async {
    PermissionStatus checkResultCamera =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (checkResultCamera.value == 0) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.camera]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
            if (status[PermissionGroup.camera].value == 2) {
              return true;
            } else {
              return false;
            }
          });
    } else {
      return true;
    }
  }

  checkPermissionMicroPhone() async {
    PermissionStatus checkResultMicroPhone = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);
    if (checkResultMicroPhone.value == 0) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
            if (status[PermissionGroup.microphone].value == 2) {
              return true;
            } else {
              return false;
            }
          });
    } else {
      return true;
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
    final Directory appDirectory = await getExternalStorageDirectory();
    final String pictureDirectory = '${appDirectory.path}/Pictures';
    await Directory(pictureDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$pictureDirectory/${currentTime}.jpg';
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
