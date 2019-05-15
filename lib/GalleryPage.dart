import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/CustomAppBar.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _MyGalleryPageState createState() => _MyGalleryPageState();
}

class _MyGalleryPageState extends State<GalleryPage> {
  File _image;

  Future getCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = image;
    setState(() {});
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
          navigatorRoute: "",
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
              RaisedButton(
                  color: Colors.cyanAccent,
                  child: Text("MultiPicker Image"),
                  onPressed: () {
                    _navigateCamera(context);
                  })
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            /*FloatingActionButton(
              onPressed: getCamera,
              child: new Icon(Icons.add_a_photo),
            ),*/
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingActionButton(
                onPressed: getGallery,
                child: new Icon(Icons.camera),
              ),
            ),
          ],
        ));
  }
}
