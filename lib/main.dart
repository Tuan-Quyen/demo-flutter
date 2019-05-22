import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AsynchorousPage.dart';
import 'package:flutter_app/NoAsynchorousPage.dart';
import 'package:flutter_app/QuestionPage.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/ImageLoadPage.dart';
import 'package:flutter_app/GalleryPage.dart';
import 'package:flutter_app/CameraPage.dart';
import 'package:flutter_app/MapPage.dart';
import 'ImageTestPage.dart';
import 'MultiImagePage.dart';
import 'VideoPage.dart';

main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ImageTestPage(),
        routes: <String, WidgetBuilder>{
          '/LoginPage': (BuildContext context) => LoginPage(),
          '/QuestionPage': (BuildContext context) => QuestionPage(),
          '/ImageLoadPage': (BuildContext context) => ImageLoadPage(),
          '/AsynchorousPage': (BuildContext context) => AsynchorousPage(),
          '/NoAsynchorousPage': (BuildContext context) => NoAsynchorousPage(),
          '/GalleryPage': (BuildContext context) => GalleryPage(),
          '/CameraPage': (BuildContext context) => TakePictureScreen(),
          '/MapPage': (BuildContext context) => MapPage(),
          '/MultiImagePage': (BuildContext context) => MultiImagePage()
        });
  }
}
