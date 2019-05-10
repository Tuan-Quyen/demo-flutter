import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AsynchorousPage.dart';
import 'package:flutter_app/NoAsynchorousPage.dart';
import 'package:flutter_app/QuestionPage.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/ImageLoadPage.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        routes: <String, WidgetBuilder>{
          '/LoginPage': (BuildContext context) => LoginPage(),
          '/QuestionPage': (BuildContext context) => QuestionPage(),
          '/ImageLoadPage': (BuildContext context) => ImageLoadPage(),
          '/AsynchorousPage': (BuildContext context) => AsynchorousPage(),
          '/NoAsynchorousPage': (BuildContext context) => NoAsynchorousPage()
        });
  }
}