import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ImageTestPage.dart';
import 'MultiImagePage.dart';
import 'CameraPage.dart';

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
          '/CameraPage': (BuildContext context) => TakePictureScreen(),
          '/MultiImagePage': (BuildContext context) => MultiImagePage()
        });
  }
}
