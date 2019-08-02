import 'package:flutter/material.dart';
import 'package:flutter_app/ButtonPlayerType.dart';

import 'AudioBloc.dart';

class ButtonPlayerWidget extends StatelessWidget {
  final ButtonPlayerType buttonPlayerType;
  final AudioBloc bloc;
  final Duration currentDuration, maxDuration;
  final String url;

  const ButtonPlayerWidget(
      {Key key,
      @required this.buttonPlayerType,
      @required this.bloc,
      @required this.currentDuration,
      @required this.maxDuration,
      this.url})
      : super(key: key);

  Widget buttonPlayer() {
    switch (buttonPlayerType) {
      case ButtonPlayerType.PREVIOUS:
        return Container(
          margin: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              if (currentDuration != null && maxDuration != null) {
                bloc.seek5Second(true, currentDuration);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.skip_previous, size: 40),
            ),
          ),
        );
      case ButtonPlayerType.NEXT:
        return Container(
          margin: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              if (currentDuration != null && maxDuration != null) {
                bloc.seek5Second(false, currentDuration);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.skip_next, size: 40),
            ),
          ),
        );
      case ButtonPlayerType.PLAY:
        return Container(
          margin: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              if (currentDuration != null && maxDuration != null) {
                bloc.resume();
              } else {
                bloc.play(url);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.play_arrow, size: 40),
            ),
          ),
        );
      case ButtonPlayerType.PAUSE:
        return Container(
          margin: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              if (currentDuration != null && maxDuration != null) {
                bloc.pause();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.pause, size: 40),
            ),
          ),
        );
      case ButtonPlayerType.STOP:
        return Container(
          margin: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              if (currentDuration != null && maxDuration != null) {
                bloc.stop();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.stop, size: 40),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buttonPlayer();
  }
}
