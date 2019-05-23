import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/local/MultiImageModel.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:async';
import 'package:photo_manager/photo_manager.dart';

class MultiImagePage extends StatefulWidget {
  @override
  _MultiImagePageState createState() => new _MultiImagePageState();
}

class _MultiImagePageState extends State<MultiImagePage> {
  String folderImage;
  List<AssetPathEntity> listFolder = [];
  List<MultiImageModel> imageList = [];
  List<AssetEntity> assertEntityList = [];
  List<String> _resultList = [];
  int count = 0;
  List<ImageProvider> _listProvider = [];

  Future getFolderList() async {
    listFolder = await PhotoManager.getImageAsset();
    imageList.clear();
    for (int i = 0; i < listFolder.length; i++) {
      if (i != 0) {
        addList(i);
      }
    }
  }

  Future addList(int i) async {
    await listFolder[i].assetList.then((value) {
      assertEntityList.addAll(value);
      for (int i = 0; i < assertEntityList.length; i++) {
        compressFileThumb(File(assertEntityList[i].id));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getFolderList();
  }

  void onSelectImage(int position) {
    if (this.mounted) {
      if (imageList[position].isCheck) {
        setState(() {
          count--;
          _resultList.removeAt(count);
          imageList[position] =
              MultiImageModel(imageList[position].filePath, false);
        });
      } else {
        setState(() {
          _resultList.add(imageList[position].filePath);
          count++;
          imageList[position] =
              MultiImageModel(imageList[position].filePath, true);
        });
      }
    }
    print(imageList[position].isCheck);
    print(_resultList.length);
  }

  Future compressFileThumb(File file) async {
    await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 120,
      minHeight: 120,
      quality: 30,
    ).then((value) {
      ImageProvider provider = MemoryImage(Uint8List.fromList(value));
      _listProvider.add(provider);
      imageList.add(MultiImageModel(file.path, false));
    });
    if (this.mounted) {
      setState(() {});
    }
  }

  GestureDetector _itemView(int position) {
    return GestureDetector(
        onTap: () {
          onSelectImage(position);
        },
        child: Stack(children: <Widget>[
          Image(
            height: double.infinity,
            width: double.infinity,
            image: _listProvider[position],
            fit: BoxFit.none,
            filterQuality: FilterQuality.low,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                width: 25,
                height: 25,
                child: imageList[position].isCheck
                    ? FloatingActionButton(
                        heroTag: position,
                        mini: true,
                        onPressed: () {
                          if (this.mounted) {
                            setState(() {
                              onSelectImage(position);
                            });
                          }
                        },
                        child: Text(count.toString(),
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.lightBlue)
                    : FloatingActionButton(
                        heroTag: position,
                        onPressed: () {
                          if (this.mounted) {
                            setState(() {
                              onSelectImage(position);
                            });
                          }
                        },
                        backgroundColor: Colors.transparent,
                        shape: CircleBorder(
                            side:
                                BorderSide(color: Colors.lightBlue, width: 1)),
                      ),
              ),
            ],
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Plugin example app'),
        actions: <Widget>[
          count != 0
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, _resultList);
                      },
                      child: Icon(Icons.check, size: 30, color: Colors.white)),
                )
              : Container()
        ],
      ),
      body: _listProvider.length == imageList.length
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5),
              shrinkWrap: true,
              itemCount: imageList.length,
              itemBuilder: (BuildContext, position) {
                return _itemView(position);
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
