import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/CustomLoadVideo.dart';
import 'package:video_player/video_player.dart';

import 'models/local/CameraImageVideo.dart';

class PreviewPage extends StatefulWidget {
  final FilePathImageVideo filePathImageVideo;

  const PreviewPage({Key key, @required this.filePathImageVideo})
      : super(key: key);

  @override
  _PreviewPageState createState() => new _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  Future<void> _initializeVideoPlayerFuture;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.filePathImageVideo.isImage) {
      setState(() {
        _controller = null;
        _initializeVideoPlayerFuture = null;
      });
    } else {
      setState(() {
        _controller = VideoPlayerController.file(
            File(widget.filePathImageVideo.filePath));
        _initializeVideoPlayerFuture = _controller.initialize();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
              child: !widget.filePathImageVideo.isImage
                  ? FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        return CustomLoadVideo(_controller);
                      })
                  : Image.file(
                      File(widget.filePathImageVideo.filePath),
                      filterQuality: FilterQuality.low,
                      fit: BoxFit.fill,
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: RaisedButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.transparent,
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
