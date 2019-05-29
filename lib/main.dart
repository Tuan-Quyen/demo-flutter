import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/blocs/SimpleDelegateBloc.dart';
import 'package:flutter_app/src/ui/HomePage.dart';
import 'package:flutter_app/src/ui/MoviePage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CounterBloc counterBloc = CounterBloc();
    return MaterialApp(
        title: 'Movie Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(bloc: counterBloc, child: HomePage()),
        routes: <String, WidgetBuilder>{
          '/HomePage': (BuildContext context) =>
              BlocProvider(bloc: counterBloc, child: HomePage()),
          '/MoviePage': (BuildContext context) => MoviePage(),
        });
  }
}
