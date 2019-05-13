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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Gallery Page",
          style: TextStyle(color: Colors.white, fontSize: 23),),
        color: Colors.lightBlue,
        hasLeft: false,
        hasRight: false,
      ),
      body: new Center(
        child: _image == null
            ? new Text('No image selected.')
            : new Image.file(_image),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
