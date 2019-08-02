import 'package:flutter/material.dart';
import 'package:flutter_app/ButtonPlayerWidget.dart';

import 'AudioBloc.dart';
import 'ButtonPlayerType.dart';

class AudioWidget extends StatelessWidget {
  final Duration currentDuration, maxDuration;
  final String url;
  final AudioBloc bloc;

  //show text duration if audio not play yet
  final String textDuration = "00:00";

  const AudioWidget(
      {Key key,
      @required this.currentDuration,
      @required this.maxDuration,
      @required this.url,
      @required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          value: currentDuration != null && currentDuration != null
              ? (currentDuration.inMilliseconds / maxDuration.inMilliseconds)
              : 0.0,
          onChanged: (value) {
            currentDuration != null && currentDuration != null
                ? bloc.seekTo(value, maxDuration)
                : () {};
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              currentDuration != null
                  ? Text(currentDuration.inMinutes.toString() +
                      ":" +
                      (currentDuration.inSeconds % 60).toString())
                  : Text(textDuration),
              maxDuration != null
                  ? Text(" / " +
                      maxDuration.inMinutes.toString() +
                      ":" +
                      (maxDuration.inSeconds % 60).toString())
                  : Text(" / " + textDuration)
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonPlayerWidget(
                buttonPlayerType: ButtonPlayerType.PREVIOUS,
                bloc: bloc,
                currentDuration: currentDuration,
                maxDuration: maxDuration,
              ),
              StreamBuilder(
                  initialData: true,
                  stream: bloc.isPause,
                  builder: (context, snapshot) {
                    if (snapshot.data) {
                      return ButtonPlayerWidget(
                        buttonPlayerType: ButtonPlayerType.PLAY,
                        bloc: bloc,
                        currentDuration: currentDuration,
                        maxDuration: maxDuration,
                        url: url,
                      );
                    } else {
                      return ButtonPlayerWidget(
                        buttonPlayerType: ButtonPlayerType.PAUSE,
                        bloc: bloc,
                        currentDuration: currentDuration,
                        maxDuration: maxDuration,
                      );
                    }
                  }),
              ButtonPlayerWidget(
                buttonPlayerType: ButtonPlayerType.STOP,
                bloc: bloc,
                currentDuration: currentDuration,
                maxDuration: maxDuration,
              ),
              ButtonPlayerWidget(
                buttonPlayerType: ButtonPlayerType.NEXT,
                bloc: bloc,
                currentDuration: currentDuration,
                maxDuration: maxDuration,
              ),
            ],
          ),
        )
      ],
    );
  }
}
