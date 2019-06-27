import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/QuestionPage.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/GalleryPage.dart';
import 'package:flutter_app/CameraPage.dart';
import 'package:flutter_app/MapPage.dart';
import 'package:flutter_app/SlideAnimation.dart';

List<CameraDescription> cameras;

Future<void> main() async {
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
        home: LoginPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/LoginPage':
              return SlideRightRoute(widget: LoginPage());
              break;
            case '/QuestionPage':
              return SlideRightRoute(widget: QuestionPage());
              break;
            case '/CameraPage':
              return SlideRightRoute(
                  widget: TakePictureScreen(camera: cameras.first));
              break;
            case '/GalleryPage':
              return SlideRightRoute(widget: GalleryPage());
              break;
            case '/MapPage':
              return SlideRightRoute(widget: MapPage());
              break;
          }
        },
    );
  }
}
