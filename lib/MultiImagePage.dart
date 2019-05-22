import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as im;

class MultiImagePage extends StatefulWidget {
  @override
  _MultiImagePageState createState() => new _MultiImagePageState();
}

class _MultiImagePageState extends State<MultiImagePage> {
  static const platform = const MethodChannel('samples.flutter.io/files');
  List<String> imgs = [];

  checkPermission() async {
    final statusCamera = await CheckPermission().checkPermissionCamera();
    final statusStorage = await CheckPermission().checkPermissionStorage();
    final statusMicroPhone =
    await CheckPermission().checkPermissionMicroPhone();
    if (statusCamera && statusMicroPhone && statusStorage) {
      _getImages();
    } else {
      setState(() {});
    }
  }

  Future<void> _getImages() async {
    List images;
    try {
      final List result = await platform.invokeMethod('getImages');
      images = result;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    setState(() {
      for (int i = 0; i < images.length; i++) {
        if (images[i].toString().endsWith(".jpg")) {
          imgs.add(images[i].toString());
        } else if (images[i].toString().endsWith(".png")) {
          imgs.add(images[i].toString());
        }
      }
      print(imgs);
    });
  }

  FutureBuilder _itemImage(String imgs) {
    return FutureBuilder(
      future: _loadThumb(imgs),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data; // image is ready
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<Image> _loadThumb(String imgs) async {
    // read image
    final Directory exDirectory = await getExternalStorageDirectory();
    final Directory tempDirectory = await getTemporaryDirectory();
    String exPath = '${exDirectory.path}/Pictures/' + imgs; //
    String tempPath = '${tempDirectory.path}/' + imgs; //
    print(File(exPath).toString());
    Image image = Image.file(
      File(exPath),
      fit: BoxFit.fill,
      width: 64,
      height: 64,
      repeat: ImageRepeat.noRepeat,
      filterQuality: FilterQuality.low,
    );
    return image;
    /*thumbInts = await fileImage.readAsBytes();
    ByteBuffer buffer = Uint8List.fromList(thumbInts).buffer;
    ByteData byteData = new ByteData.view(buffer);
    var _imageThumbView = new Image.memory(
      byteData.buffer.asUint8List(),
      fit: BoxFit.fill,
      gaplessPlayback: true,
      scale: 1.0,
      repeat: ImageRepeat.noRepeat,
      filterQuality: FilterQuality.none,
      width: 120,
      height: 120,
    );
    return _imageThumbView;*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Plugin example app'),
      ),
      body: imgs != null
          ? GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5),
          shrinkWrap: true,
          itemCount: imgs.length,
          itemBuilder: (context, position) {
            return _itemImage(imgs[position]);
          })
          : Container(),
      floatingActionButton: FloatingActionButton(
        heroTag: 1,
        onPressed: checkPermission,
        child: Icon(Icons.camera),
      ),
    );
  }
}
