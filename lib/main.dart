import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/ui/MoviePage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/ui/HomePage.dart';

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
        title: 'Movie Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MoviePage());
  }
}
/*class MyApp extends StatelessWidget {
  final CounterBloc _counterBloc = CounterBloc();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider<CounterBloc>(
          bloc: _counterBloc,
          child: HomePage(),
        ),);
  }
}*/
