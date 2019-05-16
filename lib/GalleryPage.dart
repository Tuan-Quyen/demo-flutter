import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:flutter_app/widgets/CustomAppBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _MyGalleryPageState createState() => _MyGalleryPageState();
}

class _MyGalleryPageState extends State<GalleryPage> {
  File _image;


  @override
  void dispose() {
    super.dispose();
  }

  checkPermission() async {
    final statusCamera = await CheckPermission().checkPermissionCamera();
    final statusStorage = await CheckPermission().checkPermissionStorage();
    final statusMicroPhone =
        await CheckPermission().checkPermissionMicroPhone();
    if (statusCamera && statusMicroPhone && statusStorage) {
      getCamera();
    }
  }

  Future getCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    await pathImage(image);
  }

  Future<String> pathImage(var image) async {
    final Directory appDirectory = await getExternalStorageDirectory();
    final String pictureDirectory = '${appDirectory.path}/Pictures';
    await Directory(pictureDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$pictureDirectory/${currentTime}.jpg';
    final File localImage = await image.copy(filePath);
    setState(() {
      _image = localImage;
    });
  }

  Future getGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    print(image.path);
    setState(() {});
  }

  _navigateCamera(BuildContext context) async {
    final result = await Navigator.pushNamed(context, "/CameraPage");
    setState(() {
      result != null ? _image = File(result) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "Gallery Page",
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          color: Colors.lightBlue,
          hasLeft: false,
          hasRight: true,
          navigatorRoute: "/MapPage",
          context: context,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? new Text('No image selected.')
                  : new Image.file(
                      _image,
                      width: 300,
                      height: 300,
                    ),
              /* RaisedButton(
                  color: Colors.cyanAccent,
                  child: Text("Capture Image"),
                  onPressed: () {
                    _navigateCamera(context);
                  })*/
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 0,
              onPressed: checkPermission,
              child: new Icon(Icons.add_a_photo),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FloatingActionButton(
                heroTag: 1,
                onPressed: getGallery,
                child: new Icon(Icons.camera),
              ),
            ),
          ],
        ));
  }
}
