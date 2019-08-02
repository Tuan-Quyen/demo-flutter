import 'package:audioplayers/audioplayers.dart';
import 'package:rxdart/rxdart.dart';

class AudioBloc{
  final AudioPlayer audioPlayer;
  //constructor audioplayer
  AudioBloc(this.audioPlayer);

  final BehaviorSubject<bool> _isPause = BehaviorSubject();

  BehaviorSubject<bool> get isPause => _isPause;

  //play function
  play(String _uri) async{
    _isPause.sink.add(false);
    await audioPlayer.play(_uri);
  }

  //pause function
  pause() async {
    _isPause.sink.add(true);
    await audioPlayer.pause();
  }

  //resume function
  resume() async {
    _isPause.sink.add(false);
    await audioPlayer.resume();
  }

  //stop function
  stop() async {
    await audioPlayer.stop().then((result) async {
      if (result == 1) {
        _isPause.sink.add(true);
        await audioPlayer.release();
      } else {
        print("Error");
      }
    });
  }

  //seek 5 second function
  seek5Second(bool previous, Duration currentDuration) async {
    if (previous) {
      await audioPlayer.seek(currentDuration - Duration(seconds: 5));
    } else {
      await audioPlayer.seek(currentDuration + Duration(seconds: 5));
    }
  }

  //seek to duration (seekbar)
  seekTo(double value, Duration maxDuration) async {
    await audioPlayer.seek(
        Duration(milliseconds: (value * maxDuration.inMilliseconds).toInt()));
  }

  dispose(){
    _isPause.close();
  }
}