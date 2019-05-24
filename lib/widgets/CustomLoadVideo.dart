import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomLoadVideo extends StatefulWidget {
  final VideoPlayerController _controller;

  CustomLoadVideo(this._controller, {Key key}) : super(key: key);

  @override
  CustomLoadVideoState createState() => CustomLoadVideoState();
}

class CustomLoadVideoState extends State<CustomLoadVideo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget._controller.value.isPlaying
              ? widget._controller.pause()
              : widget._controller.play();
          if (widget._controller.value.position.inMilliseconds ==
              widget._controller.value.duration.inMilliseconds) {
            widget._controller.pause();
            widget._controller.seekTo(Duration(milliseconds: 0));
          }
        });
      },
      child: AspectRatio(
        aspectRatio: widget._controller.value.aspectRatio,
        child: Stack(
          children: <Widget>[
            VideoPlayer(widget._controller),
            Center(
              child: Visibility(
                  visible: !widget._controller.value.isPlaying,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        widget._controller.value.isPlaying
                            ? widget._controller.pause()
                            : widget._controller.play();
                      });
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
