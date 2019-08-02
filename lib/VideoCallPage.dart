import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class VideoCallPage extends StatefulWidget {
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCallPage> {
  bool _isInChannel = false;
  final _infoStrings = <String>[];

  static final _sessions = List<VideoSession>();

  @override
  void initState() {
    super.initState();

    _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    _addRenderView(0, (viewId) {
      AgoraRtcEngine.setupLocalVideo(viewId, VideoRenderMode.Hidden);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora Flutter SDK'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(height: 320, child: _viewRows()),
              OutlineButton(
                child: Text(_isInChannel ? 'Leave Channel' : 'Join Channel',
                    style: textStyle),
                onPressed: _toggleChannel,
              ),
              Expanded(child: Container(child: _buildInfoList())),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create('dbf00ee66161432c8066cf8910da4dc4');

    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setChannelProfile(ChannelProfile.Communication);

    VideoEncoderConfiguration config = VideoEncoderConfiguration();
    config.orientationMode = VideoOutputOrientationMode.FixedPortrait;
    AgoraRtcEngine.setVideoEncoderConfiguration(config);
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {
      setState(() {
        String info = 'onJoinChannel: ' + channel + ', uid: ' + uid.toString();
        print(info);
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        String info = 'userJoined: ' + uid.toString();
        _infoStrings.add(info);
        _addRenderView(uid, (viewId) {
          AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Hidden, uid);
        });
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        String info = 'userOffline: ' + uid.toString();
        _infoStrings.add(info);
        _removeRenderView(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame =
        (int uid, int width, int height, int elapsed) {
      setState(() {
        String info = 'firstRemoteVideo: ' +
            uid.toString() +
            ' ' +
            width.toString() +
            'x' +
            height.toString();
        _infoStrings.add(info);
      });
    };
  }

  void _toggleChannel() {
    setState(() {
      if (_isInChannel) {
        _isInChannel = false;
        AgoraRtcEngine.leaveChannel();
        AgoraRtcEngine.stopPreview();
      } else {
        _isInChannel = true;
        AgoraRtcEngine.startPreview();
        AgoraRtcEngine.joinChannel("30bc51d9aecc4abeafa48d7cc9c03264", 'flutter', null, 0);
      }
    });
  }

  Widget _viewRows() {
    List<Widget> views = _getRenderViews();
    if (views.length > 0) {
      List<Widget> expandeViews = views
          .map((widget) => Expanded(child: Container(child: widget)))
          .toList();
      return Row(children: expandeViews);
    } else {
      return null;
    }
  }

  void _addRenderView(int uid, Function(int viewId) finished) {
    Widget view = AgoraRtcEngine.createNativeView(uid, (viewId) {
      _getVideoSession(uid).viewId = viewId;
      if (finished != null) {
        finished(viewId);
      }
    });
    VideoSession session = VideoSession(uid, view);
    _sessions.add(session);
  }

  void _removeRenderView(int uid) {
    VideoSession session = _getVideoSession(uid);
    if (session != null) {
      _sessions.remove(session);
    }
    AgoraRtcEngine.removeNativeView(session.viewId);
  }

  VideoSession _getVideoSession(int uid) {
    return _sessions.firstWhere((session) {
      return session.uid == uid;
    });
  }

  List<Widget> _getRenderViews() {
    return _sessions.map((session) => session.view).toList();
  }

  static TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.blue);

  Widget _buildInfoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 24,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(_infoStrings[i]),
        );
      },
      itemCount: _infoStrings.length,
    );
  }
}

class VideoSession {
  int uid;
  Widget view;
  int viewId;

  VideoSession(int uid, Widget view) {
    this.uid = uid;
    this.view = view;
  }
}
