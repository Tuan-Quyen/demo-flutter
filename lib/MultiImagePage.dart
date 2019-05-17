import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker/src/asset.dart';

class MultiImagePage extends StatefulWidget {
  @override
  _MyMultiImagePageState createState() => new _MyMultiImagePageState();
}

class _MyMultiImagePageState extends State<MultiImagePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery Demo',
      home: MyHomePage(title: 'Multi Image Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Asset> _images = List();
  String _error = '';

  void _pickImages() async {
    List<Asset> resultList = List<Asset>();
    String error = '';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }

    if (!mounted) return;

    setState(() {
      _images = resultList;
      _error = error;
    });
  }

  Widget _getContent() {
    if (_error.length > 0) {
      return Center(
        child: Text(_error),
      );
    }

    if (_images.length == 0) {
      return Center(
        child: Text('Please select some images ...'),
      );
    }

    return PageView.builder(
      itemBuilder: (context, index) {
        return Center(
          child: AssetView(
            _images[index],
            key: UniqueKey(),
          ),
        );
      },
      itemCount: _images.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _getContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        tooltip: 'Pick Images',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AssetView extends StatefulWidget {
  final Asset _asset;

  AssetView(
      this._asset, {
        Key key,
      }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AssetState(this._asset);
}

class AssetState extends State<AssetView> {
  Asset _asset;
  AssetState(this._asset);

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    await this._asset.requestThumbnail(300, 300, quality: 50);

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}