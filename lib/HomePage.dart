import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app/AudioWidget.dart';

import 'AudioBloc.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioBloc bloc;
  String _uri =
      "https://vnso-zn-5-tf-mp3-s1-zmp3.zadn.vn/33b357257c62953ccc73/2725426232164651929?authen=exp=1564815444~acl=/33b357257c62953ccc73/*~hmac=bc4968a6f074a84c3b2591580025d3c2";

  @override
  void initState() {
    super.initState();
    bloc = AudioBloc(audioPlayer);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Player"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<Duration>(
                stream: audioPlayer.onDurationChanged,
                builder: (context, maxDuration) {
                  return StreamBuilder<Duration>(
                    stream: audioPlayer.onAudioPositionChanged,
                    builder: (context, currentDuration) {
                      if (currentDuration.data != null &&
                          maxDuration.data != null) {
                        if (currentDuration.data.inMilliseconds ==
                            maxDuration.data.inMilliseconds) {
                          bloc.stop();
                        }
                      }
                      return AudioWidget(
                        url: _uri,
                        currentDuration: currentDuration.data,
                        maxDuration: maxDuration.data,
                        bloc: bloc,
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
