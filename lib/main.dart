
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'message_detail.dart';
import 'model/NotificationBase.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  int counter = 0;
  String _appBadgeSupported = 'Unknown';
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();

  }

  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }

  void firebaseCloudMessaging_Listeners() {

    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

        if (Platform.isIOS) {
          var notiData = NotificationIOS.fromJson(message);
          setState(() {
            counter = notiData.aps.badge;
          });
        } else {
          var notiData = NotificationAndroid.fromJson(message);
          setState(() {
            counter = int.tryParse(notiData.data.badge);
          });
        }

        FlutterAppBadger.updateBadgeCount(counter);
      },

      onResume: (Map<String, dynamic> message) async {
        ontapBannerNotification(message);
      },

      onLaunch: (Map<String, dynamic> message) async {
        ontapBannerNotification(message);
      },

    );

    _firebaseMessaging.getToken();
  }

  void ontapBannerNotification(Map<String, dynamic> message) {
    if (Platform.isIOS) {
      var notiIOSData = NotificationIOS.fromJson(message);
      var notiData = NotificationData.storeData(notiIOSData.title, notiIOSData.overview, notiIOSData.aps.badge);
      _navigateToItemDetail(notiData);
    } else {
      var notiAndroidData = NotificationAndroid.fromJson(message);
      var notiData = NotificationData.storeData(notiAndroidData.data.title, notiAndroidData.data.overview, int.tryParse(notiAndroidData.data.badge));
      _navigateToItemDetail(notiData);
    }
  }

  void iOS_Permission() {

    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );

    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _navigateToItemDetail(NotificationData message) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(message)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Badge"),
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.notifications), onPressed: () {
                setState(() {
                  counter = 0;
                  FlutterAppBadger.removeBadge();
                });
              }),
              counter != 0 ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ) : new Container()
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print("Increment Counter");
        setState(() {
          counter++;
        });
      }, child: Icon(Icons.add),),
    );
  }
}
