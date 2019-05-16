import 'package:camera/camera.dart';
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

List<CameraDescription> cameras;

Future<void> main() async{
  cameras = await availableCameras();
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
        home: GalleryPage(),
        routes: <String, WidgetBuilder>{
          '/LoginPage': (BuildContext context) => LoginPage(),
          '/QuestionPage': (BuildContext context) => QuestionPage(),
          '/ImageLoadPage': (BuildContext context) => ImageLoadPage(),
          '/AsynchorousPage': (BuildContext context) => AsynchorousPage(),
          '/NoAsynchorousPage': (BuildContext context) => NoAsynchorousPage(),
          '/GalleryPage': (BuildContext context) => GalleryPage(),
          '/CameraPage': (BuildContext context) => TakePictureScreen(camera: cameras.first,),
          '/MapPage': (BuildContext context) => MapPage(),
        });
  }
}