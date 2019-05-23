import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ImageTestPage.dart';
import 'MultiImagePage.dart';
import 'LoginPage.dart';
import 'QuestionPage.dart';
import 'ImageLoadPage.dart';
import 'AsynchorousPage.dart';
import 'NoAsynchorousPage.dart';
import 'GalleryPage.dart';
import 'CameraPage.dart';
import 'MapPage.dart';

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
        home: ImagePage(),
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
